sudo kill `pgrep openocd`
sudo openocd -f interface/picoprobe.cfg -f target/rp2040.cfg -c "program /tree/projects/github/postal-pico-rom-reader/firmware/build/rom-reader.elf verify reset exit"
