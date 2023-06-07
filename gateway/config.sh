#!/usr/bin/env bash

ISO_TIME=$(date +"%Y-%m-%d_%H-%M-%S")
echo "Start config gateway..."

if [ -z "$NEXTCLOUD_DOMAINS" ] && [ -z "$JELLYFIN_DOMAINS" ]; then
    echo ""
    echo "env NEXTCLOUD_DOMAINS or JELLYFIN_DOMAINS must be set"
    exit 1
fi

if [ -f Caddyfile ]; then
    echo ""
    echo "Backing up Caddyfile..."
    mv Caddyfile Caddyfile.$ISO_TIME
fi

if [ ! -z "$NEXTCLOUD_DOMAINS" ]; then
    echo ""
    echo "Writing nextcloud config into Caddyfile..."
    echo "" >> Caddyfile
    echo "# NextCloud" >> Caddyfile
    SERVER_NAMES=''
    for DOMAIN in $NEXTCLOUD_DOMAINS; do
        SERVER_NAMES=`echo $SERVER_NAMES $DOMAIN:80`
    done
    SERVER_NAMES=${SERVER_NAMES// /,}
    cat ./templates/Caddyfile.nextcloud | sed "s/{{SERVER_NAMES}}/$SERVER_NAMES/g" >> Caddyfile
fi

if [ ! -z "$JELLYFIN_DOMAINS" ]; then
    echo ""
    echo "Writing jellyfin config into Caddyfile..."
    echo "" >> Caddyfile
    echo "# Jellyfin" >> Caddyfile
    SERVER_NAMES=''
    for DOMAIN in $JELLYFIN_DOMAINS; do
        SERVER_NAMES=`echo $SERVER_NAMES $DOMAIN:80`
    done
    SERVER_NAMES=${SERVER_NAMES// /,}
    cat ./templates/Caddyfile.jellyfin | sed "s/{{SERVER_NAMES}}/$SERVER_NAMES/g" >> Caddyfile
fi

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
sed -i "s/{{TUNNEL_TOKEN}}/$TUNNEL_TOKEN/g" docker-compose.yml

echo ""
echo "Config gateway done!"
echo '  use `docker-compose up -d` to start gateway containers'
