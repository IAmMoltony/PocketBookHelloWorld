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

# TODO replace SDKPATH with your path and set ARCH to the appropriate architecture!
# Also replace SDKLIBDIR.
# If using PBSDK, set to arm-linux/lib
# If using FRSCSDK, set to arm-none-linux-gnueabi/sysroot/usr/lib
# If using SDK_481, set to arm-obreey-linux-gnueabi/sysroot/usr/lib
make app PLATFORM=ARM SDKPATH=$HOME/pocketbook-sdk/FRSCSDK ARCH=arm-none-linux-gnueabi SDKLIBDIR=arm-none-linux-gnueabi/sysroot/usr/lib || exit 1

# TODO replace INSTALLPATH with your path!
if [ "$doInstall" == "1" ]; then
    make install PLATFORM=ARM SDKPATH=/h ARCH=aaa SDKLIBDIR=fjfj INSTALLPATH=/media/$USER/PB616/applications
fi