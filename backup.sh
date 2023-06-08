#!/usr/bin/env bash

cd "$(dirname "$0")"
ISO_TIME=$(date +"%Y-%m-%d_%H-%M-%S")

if [ -f backup.tar.gz ]; then
    echo "backup.tar.gz already exists, rename to backup.tar.gz.${ISO_TIME}..."
    mv backup.tar.gz backup.tar.gz.${ISO_TIME}
fi

tar -zcpf backup.tar.gz --exclude=backup.tar.gz* ./*
