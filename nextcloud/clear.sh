#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "Removing postgres, redis, data in $PWD..."
sudo rm -rf postgres redis data
