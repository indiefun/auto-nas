#!/usr/bin/env bash

cd "$(dirname "$0")"
echo "Into $PWD..."

if [ -d postgres ]; then
    echo "Removing postgres..."
    rm -rf postgres
fi

if [ -d redis ]; then
    echo "Removing redis..."
    rm -rf redis
fi

if [ -d data ]; then
    echo "Removing data..."
    rm -rf data
fi

echo ""
echo "Clear Done!"
