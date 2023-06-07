#!/usr/bin/env bash

# info: https://docs.docker.com/engine/install/debian/
# Supported versions:
#   Debian Bookworm 12 (testing)
#   Debian Bullseye 11 (stable)
#   Debian Buster 10 (oldstable)

# Uninstall old versions
read -p "Do you want to uninstall old versions? [Y/n] " -n 1 -r WANT_UNINSTALL
if [[ $WANT_UNINSTALL =~ ^[Yy]$ ]]; then
    echo "Uninstalling old versions..."
    for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
else
    echo "Skipping uninstalling old versions..."
fi

# Update the apt package index and install packages to allow apt to use a repository over HTTPS
echo "Updating package index and install packages to allow apt to use a repository over HTTPS..."
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg

# Add Docker’s official GPG key
echo "Adding Docker’s official GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Set up the repository
echo "Setting up the repository..."
echo \
"deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install docker
echo "Installing docker..."
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin