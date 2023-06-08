#!/usr/bin/env bash

cd "$(dirname "$0")"

for MODULE in nextcloud jellyfin gateway; do
    if [ -f $MODULE/docker-compose.yml ]; then
        echo ""
        echo "Start $MODULE..."
        cd ./$MODULE
        docker-compose up -d
        cd ..
    fi
done

echo ""
echo "All started!"
