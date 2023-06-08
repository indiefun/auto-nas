#!/usr/bin/env bash

ISO_TIME=$(date +"%Y-%m-%d_%H-%M-%S")
echo "Start config..."

echo ""
echo "Nextcloud domains: (skip installation if empty)"
echo "  separated by spaces"
echo "  no http or https prefix"
echo "  e.g. nextcloud.example.com nextcloud.example.org"
read -p "input nextcloud domains: " NEXTCLOUD_DOMAINS

echo ""
echo "Jellyfin domains: (skip installation if empty)"
echo "  separated by spaces"
echo "  no http or https prefix"
echo "  e.g. jellyfin.example.com jellyfin.example.org"
read -p "input jellyfin domains: " JELLYFIN_DOMAINS

echo ""
echo "Cloudflare tunnel token: (skip installation if empty)"
read -p "input cloudflare tunnel token: " TUNNEL_TOKEN

for MODULE in gateway nextcloud jellyfin; do
    if [ -f $MODULE/config.sh ]; then
        echo ""
        NEXTCLOUD_DOMAINS="$NEXTCLOUD_DOMAINS" JELLYFIN_DOMAINS="$JELLYFIN_DOMAINS" TUNNEL_TOKEN="$TUNNEL_TOKEN" ./$MODULE/config.sh
    fi
    if [ "$?" != "0" ]; then
        echo ""
        exit $?
    fi
done

echo ""
echo "All config done!"
