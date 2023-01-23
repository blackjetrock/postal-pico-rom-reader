# Generated Cmake Pico project file

cmake_minimum_required(VERSION 3.13)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

# initalize pico_sdk from installed location
# (note this can come from environment, CMake cache etc)
set(PICO_SDK_PATH "/tree/downloaded_tools/pico/pico-sdk")

# Pull in Raspberry Pi Pico SDK (must be before project)
include(pico_sdk_import.cmake)
include(pico_extras_import.cmake)

project(pico-rom-em C CXX ASM)

# Initialise the Raspberry Pi Pico SDK
pico_sdk_init()

# SD FAT LIB
add_subdirectory(../no-OS-FatFS-SD-SPI-RPi-Pico/FatFs_SPI build)

# Add executable. Default name is the project name, version 0.1

add_executable(pico-rom-em pico-rom-em.c )

pico_set_program_name(pico-rom-em "pico-rom-em")
pico_set_program_version(pico-rom-em "0.1")

#pico_enable_stdio_uart(pico-rom-em 0)
pico_enable_stdio_usb(pico-rom-em 1)

# Add the standard library to the build
target_link_libraries(pico-rom-em pico_stdlib)

IF (NOT DEFINED N_SD_CARDS)
    SET(N_SD_CARDS 1)
ENDIF()
target_compile_definitions(pico-rom-em PUBLIC DEBUG N_SD_CARDS=${N_SD_CARDS})

# Add any user requested libraries
target_link_libraries(pico-rom-em
        #hardware_i2c
        hardware_pio
        hardware_clocks
	hardware_adc
        pico_sd_card
        pico_multicore
	FatFs_SPI
        )

pico_add_extra_outputs(pico-rom-em)

