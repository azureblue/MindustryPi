# MindustryRPi
### [Mindustry](https://github.com/Anuken/Mindustry) for Raspberry Pi!
#### ...and probably other armv7 or aarch64

The JAR file for the Raspberry Pi is inside Assets in the Releases section: https://github.com/azureblue/MindustryRPi/releases

What is needed:
- SDL (sudo apt install libsdl2-2.0)
- OpenAL (sudo apt install libopenal1, but probably you already have this one...)
- java (sudo apt install openjdk-11-jre)

Raspberry Pi configuration:
- vc4 fake/full kms driver (dtoverlay=vc4-fkms-v3d or dtoverlay=vc4-kms-v3d in /boot/config.txt)
- proper gpu_mem setting (tested with 128mb)
- recommended RPi overclocking (yet on your own responsibility :P) ;) 
