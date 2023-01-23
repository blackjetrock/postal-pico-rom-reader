# Postal Pico ROM Reader

This is a ROM reader that is designed to be an easy to use, simple ROM dumping tool.
It should be possible to send the dumper to someone in th epost, have them plug a ROM in and get
a dump of that ROM stored in the device flash. The device can then optionally dump
more ROMs and then be sent back to the person who wants the dumps. The dumps are then extracted from the 
device flash.

The dumper can also dump ROM contents to the USB port it is powered by.

<img src="https://user-images.githubusercontent.com/31587992/214004005-6004db27-6815-4894-b707-9b3878e415d8.jpg" width="300" />

Hardware
========

The dumper is basically just a Pico attached to a ROM socket with serial resistors. It is making use of the 
possible/probably 5V tolerance of its GPIO lines-*-. The control signals are attached through low value 
resistors as they drive the ROm and aren't subject to 5V. The data lines are 5V and come into the Pico
though cowardly 28K resistors. 

Firmware
========

The firmware uses the USB serial poirt for interactions with the user. It uses the flash of the Pico for firmware 
and also has configuration data stored in part of the flash. ROM dumps stored in several 'slots' of 16K each so
an external non-volatile device isn't needed.
the USB serial has a menu system that can be entered at boot-up and used to set the non-volatile
configuration data that determines how the dumper will work. Slots can be cleared etc and data dumped from the menu
system.



-*-I saw a post somewhere on the internet, by Eben Upton I think, which said that the Pico GPIOs were *probably*
5V tolerant. i thought I'd (carefully) test that here. Unfortunately I can't find th epost any more.
