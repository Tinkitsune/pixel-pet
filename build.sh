#!/bin/bash
# Build PixelPet.app
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$DIR/PixelPet.app/Contents/MacOS"
mkdir -p "$DIR/PixelPet.app/Contents/Resources"

# Compile
swiftc "$DIR/PixelPet.swift" -o "$DIR/PixelPet.app/Contents/MacOS/PixelPet" -framework Cocoa -framework WebKit

# Generate app icon from icon.png if it exists and iconutil is available
if [ -f "$DIR/icon.png" ] && command -v iconutil &>/dev/null; then
    ICONSET=$(mktemp -d)/icon.iconset
    mkdir -p "$ICONSET"
    for s in 16 32 64 128 256 512 1024; do
        sips -z $s $s "$DIR/icon.png" --out "$ICONSET/icon_${s}.png" &>/dev/null
    done
    mv "$ICONSET/icon_16.png" "$ICONSET/icon_16x16.png"
    cp "$ICONSET/icon_32.png" "$ICONSET/icon_16x16@2x.png"
    mv "$ICONSET/icon_32.png" "$ICONSET/icon_32x32.png"
    mv "$ICONSET/icon_64.png" "$ICONSET/icon_32x32@2x.png"
    mv "$ICONSET/icon_128.png" "$ICONSET/icon_128x128.png"
    cp "$ICONSET/icon_256.png" "$ICONSET/icon_128x128@2x.png"
    mv "$ICONSET/icon_256.png" "$ICONSET/icon_256x256.png"
    cp "$ICONSET/icon_512.png" "$ICONSET/icon_256x256@2x.png"
    mv "$ICONSET/icon_512.png" "$ICONSET/icon_512x512.png"
    mv "$ICONSET/icon_1024.png" "$ICONSET/icon_512x512@2x.png"
    iconutil -c icns "$ICONSET" -o "$DIR/PixelPet.app/Contents/Resources/AppIcon.icns"
    echo "App icon generated."
fi

echo "Build complete! Run: open $DIR/PixelPet.app"
