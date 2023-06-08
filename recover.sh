#!/usr/bin/env bash

cd "$(dirname "$0")"

if [ ! -f backup.tar.gz ]; then
    echo "backup.tar.gz not found, aborting..."
    exit
fi

tar -zxpf backup.tar.gz
