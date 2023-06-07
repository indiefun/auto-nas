#!/usr/bin/env bash

ISO_TIME=$(date +"%Y-%m-%d_%H-%M-%S")
echo "Start config jellyfin..."

# backup docker-compose.yml if exists
if [ -f docker-compose.yml ]; then
    echo ""
    echo "Backing up docker-compose.yml..."
    mv docker-compose.yml docker-compose.yml.$ISO_TIME
fi

echo ""
echo "Copying template to docker-compose.yml..."
cp ./templates/docker-compose.yml docker-compose.yml

echo ""
echo "Config jellyfin done!"
echo '  use `docker-compose up -d` to start jellyfin containers'
