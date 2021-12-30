# MindustryRPi
### [Mindustry](https://github.com/Anuken/Mindustry) for Raspberry Pi (32 and 64 bit)!
#### ...and probably other armv7 or aarch64

The JAR file for the Raspberry Pi is inside Assets in the Releases section: https://github.com/azureblue/MindustryRPi/releases

How to run:
#### java -jar MindustryPi.jar

What is needed:
- newest RaspberryPi OS (bullseye)
- SDL (sudo apt install libsdl2-2.0)
- OpenAL (sudo apt install libopenal1, but probably you already have this one...)
- java (sudo apt install openjdk-11-jre or newer - can be 14 or even 17)

Raspberry Pi configuration:
- vc4 full/fake kms driver (dtoverlay=vc4-kms-v3d or dtoverlay=vc4-fkms-v3d in /boot/config.txt)
- proper gpu_mem setting (tested with 128mb)
- recommended RPi overclocking (yet on your own responsibility :P) ;)
