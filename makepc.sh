#!/bin/bash

doClean=0
doRun=0

while [[ $# -gt 0 ]]; do
    case $1 in
        -r|--run)
            doRun=1
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

. ./linux.env

make app PLATFORM=Linux SDKPATH=$SDKPATH || exit 1

if [ "$doRun" == "1" ]; then
    make run PLATFORM=Linux SDKPATH=$SDKPATH
fi
