#!/usr/bin/env bash

if [ -z "$NEXTCLOUD_DOMAINS" ]; then
    echo "Skip nextcloud config"
    exit
fi

cd "$(dirname "$0")"
ISO_TIME=$(date +"%Y-%m-%d_%H-%M-%S")

echo "Start config nextcloud..."

echo ""
echo "Generating random password for postgres..."
POSTGRES_PASSWORD=$(< /dev/urandom tr -dc _@A-Za-z0-9 | head -c8)

echo ""
echo "Generating random password for redis..."
REDIS_PASSWORD=$(< /dev/urandom tr -dc _@A-Za-z0-9 | head -c8)

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
echo "Replacing variables in docker-compose.yml..."
sed -i "s/{{POSTGRES_PASSWORD}}/$POSTGRES_PASSWORD/g" docker-compose.yml
sed -i "s/{{REDIS_PASSWORD}}/$REDIS_PASSWORD/g" docker-compose.yml
sed -i "s/{{TRUSTED_DOMAINS}}/$NEXTCLOUD_DOMAINS/g" docker-compose.yml

echo ""
echo "Config nextcloud done!"
echo '  use `docker-compose up -d` to start nextcloud containers'
