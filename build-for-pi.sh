#!/bin/bash

MINDUSTRY_RELEASE=$1
ARC_RPI_COMMIT=$2
BITS=${3:-32}
LIB_SUFFIX=""
if [[ $BITS = "64" ]]; then
    LIB_SUFFIX="64"
fi

wget https://github.com/azureblue/Arc/archive/$2.zip -O Arc-$2.zip  || exit -1

7z x Arc-$2.zip -y || exit -1
cd Arc-$2

echo building Arc
./gradlew natives || exit -1
./gradlew sdlnatives || exit -1
./gradlew freetypeNatives  || exit -1

cd ..

mkdir Mindustry
cd Mindustry
wget https://github.com/Anuken/Mindustry/releases/download/$1/Mindustry.jar -O Mindustry.jar || exit -1

7z x Mindustry.jar -y || exit -1
rm *.dll *.so *.dylib
rm -r win32-x86* linux-x86-64 darwin
echo replacing sdl backend
rm -r arc/backend/sdl || exit -1 
cp -r ../Arc-$2/backends/backend-sdl/build/classes/java/main/arc/backend/sdl arc/backend || exit -1
cp ../Arc-$2/backends/backend-sdl/libs/linuxarm$BITS/libsdl-arcarm$LIB_SUFFIX.so . || exit -1
strip libsdl-arcarm$LIB_SUFFIX.so || exit -1
cp ../Arc-$2/natives/natives-desktop/libs/libarcarm$LIB_SUFFIX.so . || exit -1
strip libarcarm$LIB_SUFFIX.so || exit -1
cp ../Arc-$2/natives/natives-freetype-desktop/libs/libarc-freetypearm$LIB_SUFFIX.so . || exit -1
strip libarc-freetypearm$LIB_SUFFIX.so || exit -1

wget https://raw.githubusercontent.com/Anuken/Mindustry/$1/core/src/mindustry/ui/dialogs/SettingsMenuDialog.java -O mindustry/ui/dialogs/SettingsMenuDialog.java || exit -1
sed -i 's/graphics.checkPref("animatedwater",.*);/graphics.checkPref("animatedwater", false);/g' mindustry/ui/dialogs/SettingsMenuDialog.java
sed -i 's/graphics.checkPref("animatedshields",.*);/graphics.checkPref("animatedshields", false);/g' mindustry/ui/dialogs/SettingsMenuDialog.java
sed -i 's/"bloom", true/"bloom", false/g' mindustry/ui/dialogs/SettingsMenuDialog.java
javac  mindustry/ui/dialogs/SettingsMenuDialog.java

rm Mindustry.jar

7z a ../MindustryPi_$BITS.jar *
