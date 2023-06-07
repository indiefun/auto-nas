#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "Removing cache, config, media in $PWD..."
sudo rm -rf cache config media
