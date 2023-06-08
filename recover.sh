#!/usr/bin/env bash

cd "$(dirname "$0")"

./status.sh

read -p "Do you have stopped all containers? [y/N] (see status output above): " -n 1 -r CONFIRMED
if ! [[ $CONFIRMED =~ ^[Yy]$ ]]; then
    echo "Retry after stoped all containers, ABORTING..."
    exit
fi
echo

if [ ! -f backup.tar.gz ]; then
    echo "backup.tar.gz not found, aborting..."
    exit 1
fi

echo "backup.tar.gz found, extracting..."
tar -zxpf backup.tar.gz

echo "backup.tar.gz extracted!"
