#!/usr/bin/env bash

cd "$(dirname "$0")"
echo "Into $PWD..."

if [ -d cache ]; then
    echo "Removing cache..."
    rm -rf cache
fi

if [ -d config ]; then
    echo "Removing config..."
    rm -rf config
fi

if [ -d media ]; then
    echo "Removing media..."
    rm -rf media
fi

echo ""
echo "Clear Done!"
