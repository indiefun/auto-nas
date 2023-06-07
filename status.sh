#!/usr/bin/env bash

for MODULE in nextcloud jellyfin gateway; do
    echo ""
    echo "Status $MODULE..."
    cd ./$MODULE
    docker-compose ps
    cd ..
done

echo ""
echo "All status shown!"
