#!/usr/bin/env bash

# info: https://docs.docker.com/engine/install/centos/
# Supported versions:
#   CentOS 7
#   CentOS 8 (stream)
#   CentOS 9 (stream)

# Uninstall old versions
read -p "Do you want to uninstall old versions? [Y/n] " -n 1 -r WANT_UNINSTALL
if [[ $WANT_UNINSTALL =~ ^[Yy]$ ]]; then
    echo "Uninstalling old versions..."
    sudo yum remove docker \
        docker-client \
        docker-client-latest \
        docker-common \
        docker-latest \
        docker-latest-logrotate \
        docker-logrotate \
        docker-engine
else
    echo "Skipping uninstalling old versions..."
fi


# Set up the repository
echo "Setting up the repository..."
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install docker
echo "Installing docker..."
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start docker
echo "Starting docker..."
sudo systemctl start docker
