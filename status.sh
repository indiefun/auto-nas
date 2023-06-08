#!/usr/bin/env bash

cd "$(dirname "$0")"

for MODULE in nextcloud jellyfin gateway; do
    if [ -f $MODULE/docker-compose.yml ]; then
        echo ""
        echo "Status $MODULE..."
        cd ./$MODULE
        docker-compose ps
        cd ..
    fi
done

echo ""
echo "All status shown!"
