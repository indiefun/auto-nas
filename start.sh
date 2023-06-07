#!/usr/bin/env bash

for MODULE in nextcloud jellyfin gateway; do
    echo ""
    echo "Start $MODULE..."
    cd ./$MODULE
    docker-compose up -d
    cd ..
done

echo ""
echo "All started!"
