////////////////////////////////////////////////////////////////////////////////
//
// Pico ROM Reader
//
// Reads data out of a 24 pin EPROM
// Data is dumped onto the USB serial
//
// A startup option allows configuration data to be set up.
// At the top of flash memory we have two areas. One holds config
// data and one holds slots for ROM dumps. The tool only works with up to
// 16K ROMs so we have 16K slots. Slots are only ever filled by the dump code
// once full the slot have to be deleted with a flash sector erase.
//
////////////////////////////////////////////////////////////////////////////////

#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include "pico/stdlib.h"
//##include "hardware/pio.h"
//##include "hardware/clocks.h"
#include "hardware/flash.h"

// Use this if breakpoints don't work
#define DEBUG_STOP {volatile int x = 1; while(x) {} }

////////////////////////////////////////////////////////////////////////////////
//
//

// Only scan once, if multiple dumps needed then use a loop around the entire tool
// This makes the post processing easier.

#define NUM_SCANS    1
#define SLOT_SIZE    (16*1024)

// How many slots there are. We could have very many slots, why not?
#define NUM_SLOTS    50

//-----------------------------------------------------------------------------

// Config sector
#define FLASH_CONFIG_OFFSET (1024 * 1024)
uint8_t *flash_config_contents = (uint8_t *) (XIP_BASE + FLASH_CONFIG_OFFSET);

// ROM image slots
#define FLASH_SLOT_OFFSET (1028 * 1024)
uint8_t *flash_slot_contents   = (uint8_t *) (XIP_BASE + FLASH_SLOT_OFFSET);


//--------------------------------------------------------------------------------

typedef enum
  {
   USB_DUMP = 0,
   SLOT_DUMP,
   NUM_SETUP_MODES,
  } SETUP_MODE;

char *setup_mode_name[NUM_SETUP_MODES] =
  {
   "USB DUMP",
   "SLOT_DUMP",
  };

typedef struct {
  int valid_a;     // magic number and an 
  int valid_b;     // inverterted magic number
  int mode;        // Mode we are in
  int usb_dump_count;   // Incremented after every dump
  int slot_dump_count;  // Incremented after every slot dump
} CONFIG_RECORD;

CONFIG_RECORD *config_record = (CONFIG_RECORD *) (XIP_BASE + FLASH_CONFIG_OFFSET);
CONFIG_RECORD copy_config_record;

#define CONFIG_MAGIC_A 0xCFAA0134
#define CONFIG_MAGIC_B 0xCFBB5623

// RAM slot which we copy to flash once filled
uint8_t slot_data[SLOT_SIZE];

//--------------------------------------------------------------------------------

void dump_slot(int slotnum);
void display_slot_map(void);
void clear_slot_data(void);

//------------------------------------------------------------------------------

const int LED_PIN = 25;

const int D0_PIN = 0;
const int D1_PIN = 1;
const int D2_PIN = 2;
const int D3_PIN = 3;
const int D4_PIN = 4;
const int D5_PIN = 5;
const int D6_PIN = 6;
const int D7_PIN = 7;

//
// The address lines (always inputs)
//
const int  A0_PIN  =  8;
const int  A1_PIN  =  9;
const int  A2_PIN  = 10;
const int  A3_PIN  = 11;
const int  A4_PIN  = 12;
const int  A5_PIN  = 13;
const int  A6_PIN  = 14;
const int  A7_PIN  = 15;
const int  A8_PIN  = 16;
const int  A9_PIN  = 17;
const int  A10_PIN = 18;
const int  A11_PIN = 19;
const int  A12_PIN = 20;
const int  A13_PIN = 21;  // Actually CS pin sometimes but can scan as if it was an address line

// Arrays for setting GPIOs up
#define NUM_ADDR 14
#define NUM_DATA 8

const int address_pins[NUM_ADDR] =
  {
   A0_PIN,
   A1_PIN,
   A2_PIN,
   A3_PIN,
   A4_PIN,
   A5_PIN,
   A6_PIN,
   A7_PIN,
   A8_PIN,
   A9_PIN,
   A10_PIN,
   A11_PIN,
   A12_PIN,
   A13_PIN,   // Could be CS pin
  };

const int data_pins[NUM_DATA] =
  {
   D0_PIN,
   D1_PIN,
   D2_PIN,
   D3_PIN,
   D4_PIN,
   D5_PIN,
   D6_PIN,
   D7_PIN,
  };

////////////////////////////////////////////////////////////////////////////////
//
// Set the address lines to a value
//
////////////////////////////////////////////////////////////////////////////////

void set_address(int addr)
{
  for(int i=0; i<NUM_ADDR; i++)
    {
      if( addr & (1<<i) )
	{
	  gpio_put(address_pins[i], 1);
	}
      else
	{
	  gpio_put(address_pins[i], 0);
	}
    }
}


int read_data(void)
{
  int result = 0;
  
  for(int i=0; i<NUM_DATA; i++)
    {
      if( gpio_get(data_pins[i]) )
	{
	  result |= (1 << i);
	}
    }
  return(result);
}

////////////////////////////////////////////////////////////////////////////////


void print_hex(uint8_t *buf, int len)
{
  for (size_t i = 0; i < len; ++i)
    {
      if((i % 16) == 0)
	{
	  printf("\n");
	}
      
      printf("%02x ", buf[i]);
    }
}

////////////////////////////////////////////////////////////////////////////////

void prompt(void)
{
  printf("\n>");
}

void setup_menu(void)
{
  printf("\nSetup");
  printf("\n=====");
  printf("\n");
  printf("\n?: Display menu");
  printf("\nq: Quit");
  printf("\nc: Clear config settings");
  printf("\nC: Clear slot data");
  printf("\nd: Display config settings");
  printf("\np: Print information");
  printf("\nP: Dump config sector");
  printf("\nU: Set USB dump mode");
  printf("\nS: Set slot dump mode");
  printf("\nM: Display slot map");
  printf("\nr: Display slot");
  printf("\nz: Zero USB dump count");
  printf("\nZ: Zero Slot dump count");
}

void erase_config_sector(void)
{
  flash_range_erase(FLASH_CONFIG_OFFSET, FLASH_SECTOR_SIZE);
}

void erase_slot_data(void)
{
  flash_range_erase(FLASH_SLOT_OFFSET, SLOT_SIZE*NUM_SLOTS);
}

void program_config_record(CONFIG_RECORD *data)
{
  flash_range_program(FLASH_CONFIG_OFFSET,(uint8_t *) data, sizeof(CONFIG_RECORD));
}

void write_config_record(CONFIG_RECORD *cfg_rec)
{
  // Make record valid
  cfg_rec->valid_a = CONFIG_MAGIC_A;
  cfg_rec->valid_b = CONFIG_MAGIC_B;
  
  erase_config_sector();
  program_config_record(cfg_rec);
}

void zero_usb_dump_count(void)
{
  copy_config_record = *config_record;
  copy_config_record.usb_dump_count = 0;
  write_config_record(&copy_config_record);
}

void zero_slot_dump_count(void)
{
  copy_config_record = *config_record;
  copy_config_record.slot_dump_count = 0;
  write_config_record(&copy_config_record);
}

void increment_usb_dump_count(void)
{
  copy_config_record = *config_record;
  (copy_config_record.usb_dump_count)++;
  write_config_record(&copy_config_record);
}

void increment_slot_dump_count(void)
{
  copy_config_record = *config_record;
  (copy_config_record.slot_dump_count)++;
  write_config_record(&copy_config_record);
}

//--------------------------------------------------------------------------------

void write_data_to_slot(uint8_t *data, int slotnum)
{
  printf("\nWriting data to slot %d", slotnum);

  flash_range_program(FLASH_SLOT_OFFSET + (SLOT_SIZE * slotnum), (uint8_t *) data, SLOT_SIZE);

  printf("\nData written");
  
}

//--------------------------------------------------------------------------------
//

int slot_is_blank(int slotnum)
{
  int blank = 0;
  
  // See if all bytes in this slot are 0xff
  // Assume blank

  blank = 1;

  for(int j=0; j<SLOT_SIZE;j++)
    {
      if( *(flash_slot_contents+slotnum*SLOT_SIZE+j) !=0xFF )
	{
	  // Not blank
	  blank = 0;
	  break;
	}
    }
  
  if( blank )
    {
      // We found a slot, return its index
      return(1);
    }

  return(0);
}

//--------------------------------------------------------------------------------
//
// Find a slot that has no data in it, i.e. is full of 0xFF
// returns either the slot number or -1 if none are blank

int find_blank_slot(void)
{
  int slotnum = -1;
  
  for(slotnum=0; slotnum<NUM_SLOTS; slotnum++)
    {
      if( slot_is_blank(slotnum) )
	{
	  return(slotnum);
	}
    }

  return(-1);
}

char *get_mode_name(int mode)
{
  switch(mode)
    {
    case USB_DUMP:
    case SLOT_DUMP:
      return(setup_mode_name[mode]);      
      break;

    default:
      return("Unknown");
      break;
    }
}

////////////////////////////////////////////////////////////////////////////////
//
// Check for entry into the setup code
//
////////////////////////////////////////////////////////////////////////////////

void check_config_entry(void)
{
  int c;
  int key_pressed = 0;

  printf("\nPress any key to enter setup...\n");
  
  // Wait for a while and see if a keypress occurred
  for(int i=0; i<5; i++)
    {
      printf("  %d...", i);
      
      sleep_ms(1000);

      if( (c = getchar_timeout_us(1000)) != PICO_ERROR_TIMEOUT )
	{
	  if( (c != 0) && (c != 255) )
	    {
	      key_pressed = 1;
	      break;
	    }
	}
    }

  if( key_pressed )
    {
      printf("\nkey %d pressed", c);

      // Key was pressed, enter setup loop

      int done = 0;

      setup_menu();
      prompt();
      
      while(!done)
	{
	  if( (c = getchar_timeout_us(1000)) != PICO_ERROR_TIMEOUT )
	    {
	      // handle command
	      switch(c)
		{
		case '?':
		  setup_menu();
		  break;
		  
		case 'q':
		  done = 1;
		  break;

		case 'd':
		  printf("\nConfiguration data:");
		  printf("\n");
		  break;
		  
		case 'c':
		  // Erase config sector
		  erase_config_sector();

		  break;

		case 'C':
		  clear_slot_data();
		  break;
		  
		case 'U':
		  // Set USB mode
		  // Read config into RAM
		  copy_config_record = *config_record;
		  copy_config_record.mode = USB_DUMP;
		  write_config_record(&copy_config_record);
		  break;

		case 'S':
		  // Set SLOT mode
		  // Read config into RAM
		  copy_config_record = *config_record;
		  copy_config_record.mode = SLOT_DUMP;
		  write_config_record(&copy_config_record);
		  break;
		  
		case 'r':
		  {
		    int slot_number;
		    
		    printf("\nSlot number:");
		    scanf("%d", &slot_number);
		    dump_slot(slot_number);
		  }
		  break;

		case 'M':
		  display_slot_map();
		  break;

		case 'z':
		  zero_usb_dump_count();
		  break;

		case 'Z':
		  zero_slot_dump_count();
		  break;
		  
		case 'P':
		  // Print flash config data sector
		  print_hex(flash_config_contents, FLASH_SECTOR_SIZE);
		  break;
		  
		case 'p':
		  // print information
		  printf("\nFlash sector size: %d", FLASH_SECTOR_SIZE);
		  printf("\nFlash page size  : %d", FLASH_PAGE_SIZE);

		  printf("\nConfiguration data");
		  printf("\n");
		  print_hex(flash_config_contents, sizeof(CONFIG_RECORD));
		  printf("\n");

		  if( (config_record->valid_a == CONFIG_MAGIC_A) && (config_record->valid_b == CONFIG_MAGIC_B ))
		    {
		      printf("\nConfiguration valid");
		      printf("\nMode           : %s", get_mode_name(config_record->mode));
		      printf("\nUSB dump count : %d", config_record->usb_dump_count);
		      printf("\nSlot dump count: %d", config_record->slot_dump_count);
		      printf("\n");
		    }
		  else
		    {
		      printf("\nConfiguration NOT valid");
		    }
		  break;
		  
		default:
		  printf("\nKey press unknown: %d", c);
		  break;
		}
	      
	      prompt();
	    }
	}
    }
}


////////////////////////////////////////////////////////////////////////////////
//
// USB Dump mode
//
////////////////////////////////////////////////////////////////////////////////

void usb_dump(void)
{
  // We scan the device twice, so we can compare the two scans and check that data is
  // consistent on each scan. Data is dumped to the slot in RAM so we can use this code
  // for the slot dump mode and just copy data to flash afterwards if needed.

  int scan    = 0;
  int addr    = 0;
  int byte    = 0;
  int ascii_i = 0;
  int sloti   = 0;
  
#define LINELEN 64
  
  char ascii[LINELEN+1] = "";
  
  for(addr=0; addr < (1<<NUM_ADDR); addr++)
    {
      ascii_i = addr % LINELEN;
      
      if( (addr % LINELEN) == 0 )
	{
	  printf("\n%04X: ", addr);
	}
      
      set_address(addr);
      sleep_ms(1);
      byte = read_data();

      slot_data[sloti++] = byte;

      if( sloti > SLOT_SIZE )
	{
	  printf("\nSlot size inconsistent");
	}
      
      if( isprint(byte))
	{
	  ascii[ascii_i] = byte & 0xFF;
	}
      else
	{
	  ascii[ascii_i] = '.';    
	}
      
      printf("%02X ", byte);
      
      if( ascii_i == (LINELEN-1) )
	{
	  ascii[LINELEN] = '\0';
	  printf("  %s", ascii);
	}
    }

  // Sucessful dump, increment the count
  increment_usb_dump_count();
}

////////////////////////////////////////////////////////////////////////////////
//
// Slot Dump mode
//
////////////////////////////////////////////////////////////////////////////////

// We dump the ROM to a RAM slot then copy the data into a blank slot. If no blank
// slots then we don't copy any data.
// The ROM is dumped to RAM and displayed on USB as well, so if the slots are full
// then a USB dump still occurs

void slot_dump(void)
{
  int slotnum = -1;
  
  // Do a USB dump, which will save the data for us in slot_data[] and also
  // has done a 'backup' USB dump for us.

  // this will increment the USB dump counter
  usb_dump();

  // We have the data in RAM, now try to find somewhere in flash to store it
  slotnum = find_blank_slot();

  if( slotnum == -1 )
    {
      printf("\nNo free slots available");

      // No slots, we can do no more
      // Slot dump counter not incremented
      return;
    }

  // We have a slot to store the data in, so write it
  write_data_to_slot(slot_data, slotnum);
  increment_slot_dump_count();
}

void display_slot_map(void)
{
  printf("\nSlot Map\n");
  printf("\n\nSlot size:%d bytes\n", SLOT_SIZE);
  
  for(int s=0; s<NUM_SLOTS; s++)
    {
      printf("\n%02d: %s", s, slot_is_blank(s)?"Blank":"Used ");
    }
  
  printf("\n");
}

void dump_slot(int slotnum)
{
  printf("\nSlot %d\n", slotnum);
  
  print_hex(flash_slot_contents+slotnum*SLOT_SIZE, SLOT_SIZE);

  printf("\n");
}

void clear_slot_data(void)
{
  char answer[100];
  
  printf("\n*** CLEAR SLOT DATA ***\n");
  printf("\n\nAre you sure? (Yes/No):");

  scanf("%s", answer);
  srand(time_us_32());
  
  if( strcmp(answer, "Yes") == 0 )
    {
      int code = rand();
      int code_answer = code+1;
      
      printf("\n\nEnter code:%d:", code);

      scanf("%d", &code_answer);
      
      if( code==code_answer )
	{
	  printf("\nDeleting slot data in 10 seconds...");
	  for(int ct=1; ct<=10; ct++)
	    {
	      sleep_ms(1000);
	      printf("\n%d...", ct);
	    }
	  printf("\nDeleting...");
	  erase_slot_data();
	  printf("\nDone");
	}
    }
}

////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////

int main()
{

  char line[80];

  stdio_init_all();

  sleep_ms(3000);
  
  printf("\nPico ROM Reader V1.0\n");
  sleep_ms(1000);

  check_config_entry();
  
#if TEST_STDIO
  {
  int count;
  while (true)
    {
      count++;
      
      if( (count % 1000000) == 0 )
	{
	  sprintf(line, "\nRP2040: %d", count);
	  printf(line);
	}
    }
  }
#endif

  // LED ON solid
  gpio_init(LED_PIN);
  gpio_set_dir(LED_PIN, GPIO_OUT);
  gpio_put(LED_PIN, 1);
  
  printf("\nSetting GPIOs...");
  sleep_ms(1000);
  
  // Address lines are driven
  for (int i=0; i<NUM_ADDR; i++)
    {
      // Set up directions for the control lines
      gpio_init(address_pins[i]);
      gpio_set_dir(address_pins[i], GPIO_OUT);
    }

  // Data lines are inputs
  for (int i=0; i<NUM_DATA; i++)
    {
      // Set up directions for the control lines
      gpio_init(data_pins[i]);
      gpio_set_dir(data_pins[i], GPIO_IN);
    }


  // Perform the mode that was requested
  switch(config_record->mode)
    {
    case USB_DUMP:
      printf("\nUSB Dump\n");
      sleep_ms(1000);
      usb_dump();
      break;

    case SLOT_DUMP:
      printf("\nSlot Dump\n");
      sleep_ms(1000);
      slot_dump();
      break;

    default:
      printf("\nUnknown mode.");
      break;
    }

  // All done, flash the LED
  printf("\nDone.");
  printf("\n");
  
  while(1)
    {
      sleep_ms(250);
      gpio_put(LED_PIN, 0);
      sleep_ms(250);
      gpio_put(LED_PIN, 1);
    }
}
