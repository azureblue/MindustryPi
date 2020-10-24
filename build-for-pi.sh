#!/bin/bash

ARC_RPI_COMMIT=$1
BITS=${3:-32}
LIB_SUFFIX=""
if [[ $BITS = "64" ]]; then
    LIB_SUFFIX="64"
fi

if [ ! -f Mindustry.jar ]; then
    echo "Missing Mindustry.jar!"
    exit -1
fi

wget https://github.com/azureblue/Arc/archive/$1.zip -O Arc-$1.zip  || exit -1

7z x Arc-$1.zip -y || exit -1
cd Arc-$1

echo building Arc
./gradlew natives || exit -1
./gradlew sdlnatives || exit -1
./gradlew freetypeNatives  || exit -1

cd ..

mkdir Mindustry
cp Mindustry.jar Mindustry
cd Mindustry

7z x Mindustry.jar -y || exit -1
rm *.dll *.so *.dylib
rm -r win32-x86* linux-x86-64 darwin
echo replacing sdl backend
rm -r arc/backend/sdl || exit -1 
cp -r ../Arc-$1/backends/backend-sdl/build/classes/java/main/arc/backend/sdl arc/backend || exit -1
cp ../Arc-$1/backends/backend-sdl/libs/linuxarm$BITS/libsdl-arcarm$LIB_SUFFIX.so . || exit -1
strip libsdl-arcarm$LIB_SUFFIX.so || exit -1
cp ../Arc-$1/natives/natives-desktop/libs/libarcarm$LIB_SUFFIX.so . || exit -1
strip libarcarm$LIB_SUFFIX.so || exit -1
cp ../Arc-$1/natives/natives-freetype-desktop/libs/libarc-freetypearm$LIB_SUFFIX.so . || exit -1
strip libarc-freetypearm$LIB_SUFFIX.so || exit -1

rm Mindustry.jar

7z a ../MindustryPi_$BITS.jar *
