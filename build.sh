#!/bin/bash
# Build PixelPet.app
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$DIR/PixelPet.app/Contents/MacOS"
mkdir -p "$DIR/PixelPet.app/Contents/Resources"
swiftc "$DIR/PixelPet.swift" -o "$DIR/PixelPet.app/Contents/MacOS/PixelPet" -framework Cocoa -framework WebKit
echo "Build complete! Run: open $DIR/PixelPet.app"
