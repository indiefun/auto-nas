#!/usr/bin/env bash

# Install docker if not already installed
echo "Checking if docker is installed..."
if ! command -v docker &> /dev/null
then
    # Check os type
    OSTYPE=`cat /etc/os-release | grep '^ID=' | awk -F= '{ print $2 }'`
    echo "OSTYPE: $OSTYPE"
    if [[ -d platforms/$OSTYPE ]]; then
        ./platforms/$OSTYPE/setup.sh
    else
        echo "Unsupported OS: $OSTYPE"
        echo "info: https://docs.docker.com/engine/install/#supported-platforms"
        exit 1
    fi
    echo "docker has been installed!"
fi

# check if docker-compose is installed
echo "Checking if docker-compose is installed..."
if ! command -v docker-compose &> /dev/null
then
    echo "Installing docker-compose..."
    curl -SL https://github.com/docker/compose/releases/download/v2.18.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    echo "docker-compose has been installed!"
fi

echo "All set up!"
