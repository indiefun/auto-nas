#!/usr/bin/env bash

echo "WARNING: This script will delete all containers DATA!"
read -p "Do you want to continue? [y/N] " -n 1 -r CONFIRMED
if ! [[ $CONFIRMED =~ ^[Yy]$ ]]; then
    exit
fi

echo
echo "Deleting containers DATA..."
read -p "Are you NOT sure? [Y/n] " -n 1 -r CONFIRMED
if ! [[ $CONFIRMED =~ ^[Nn]$ ]]; then
    exit
fi

for MODULE in gateway nextcloud jellyfin; do
    cd ./$MODULE
    if [ -f ./clear.sh ]; then
        ./clear.sh
    fi
    cd ..
done
