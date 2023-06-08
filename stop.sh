#!/usr/bin/env bash

for MODULE in gateway jellyfin nextcloud; do
    if [ -f $MODULE/docker-compose.yml ]; then
        echo ""
        echo "Stop $MODULE..."
        cd ./$MODULE
        docker-compose down
        cd ..
    fi
done

echo ""
echo "All stopped!"
