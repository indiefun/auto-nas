#!/usr/bin/env bash

for MODULE in gateway jellyfin nextcloud; do
    echo ""
    echo "Stop $MODULE..."
    cd ./$MODULE
    docker-compose down
    cd ..
done

echo ""
echo "All stopped!"
