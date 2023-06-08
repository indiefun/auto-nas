#!/usr/bin/env bash

cd "$(dirname "$0")"
ISO_TIME=$(date +"%Y-%m-%d_%H-%M-%S")

./status.sh

read -p "Do you have stopped all containers? [y/N] (see status output above): " -n 1 -r CONFIRMED
if ! [[ $CONFIRMED =~ ^[Yy]$ ]]; then
    echo "Retry after stoped all containers, ABORTING..."
    exit
fi
echo

if [ -f backup.tar.gz ]; then
    echo "backup.tar.gz already exists, rename to backup.tar.gz.${ISO_TIME}..."
    mv backup.tar.gz backup.tar.gz.${ISO_TIME}
fi

echo "backup.tar.gz created, saving..."
tar -zcpf backup.tar.gz --exclude=backup.tar.gz* ./*

echo "backup.tar.gz saved!"
