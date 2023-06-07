#!/usr/bin/env bash

# info: https://docs.docker.com/engine/install/fedora/
# Supported versions:
#   Fedora 36
#   Fedora 37
#   Fedora 38

# Uninstall old versions
read -p "Do you want to uninstall old versions? [Y/n] " -n 1 -r WANT_UNINSTALL
if [[ $WANT_UNINSTALL =~ ^[Yy]$ ]]; then
    echo "Uninstalling old versions..."
    sudo dnf remove docker \
        docker-client \
        docker-client-latest \
        docker-common \
        docker-latest \
        docker-latest-logrotate \
        docker-logrotate \
        docker-selinux \
        docker-engine-selinux \
        docker-engine
else
    echo "Skipping uninstalling old versions..."
fi

# Set up the repository
echo "Setting up the repository..."
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

# Install docker
echo "Installing docker..."
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start docker
echo "Starting docker..."
sudo systemctl start docker