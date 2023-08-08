
# Hello World for PocketBook

This is a hello world app for PocketBook, designed to demonstrate how to make a simple program for PocketBook.

## Dependencies

You need to have 32-bit versions of FreeType, cURL, libjpeg62 and GTK2 installed. You also need to have gcc-multilib and g++-multilib installed. You don't need to install the dependencies if you don't want to build for Linux. PocketBook SDK is required. The SDK is available [here](https://github.com/blchinezu/pocketbook-sdk).

## Building, Running and Installing

### For Linux

To build the app for Linux, you need to install the dependencies first. Then you can run the `makepc.sh` script.

The script has 2 flags:

1. `-r` or `--run` - Run after building
2. `-c` or `--clean` - Clean before building (via `clean.sh`)

**Note**: don't forget to set your SDK directory in `makepc.sh`.

### For ARM

To build the app for ARM (to run on PocketBook), you only need to install the SDK. Then you can run the `makearm.sh` script.

The script has 2 flags:

1. `-i` or `--install` - Install after building
2. `-c` or `--clean` - Clean before building (via `clean.sh`)

**Note**: don't forget to set your SDK directory in `makearm.sh`. If you want to install the app, you need to set the install path too. The install path is the /applications directory on your PocketBook. (e.g. the PocketBook is mounted at `/media/user/PB`, so install path would be `/media/user/PB/applications`.)

**Note 2**: also don't forget to set your SDK library directory as it is different for every SDK for some reason!
