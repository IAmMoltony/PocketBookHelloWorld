#!/bin/bash

doClean=0
doInstall=0

while [[ $# -gt 0 ]]; do
    case $1 in
        -i|--install)
            doInstall=1
            shift
            ;;
        -c|--clean)
            doClean=1
            shift
            ;;
        *)
            echo "Invalid argument \`$1'"
            exit 1
            ;;
    esac
done

if [ "$doClean" == "1" ]; then
    ./clean.sh
fi

. ./arm.env

make app PLATFORM=ARM SDKPATH=$SDKPATH ARCH=$ARCH SDKLIBDIR=$SDKLIBDIR || exit 1

if [ "$doInstall" == "1" ]; then
    make install PLATFORM=ARM SDKPATH=/h ARCH=aaa SDKLIBDIR=fjfj INSTALLPATH=$INSTALLPATH
fi
