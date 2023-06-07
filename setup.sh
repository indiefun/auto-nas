#!/usr/bin/env bash

# Install docker and docker-compose if not already installed
echo "Checking if docker is installed..."
if ! command -v docker &> /dev/null
then
    # Check os type
    OSTYPE=`cat /etc/os-release | grep '^ID=' | awk -F= '{ print $2 }'`
    echo "OSTYPE: $OSTYPE"
    if [[ "$OSTYPE" == "ubuntu" ]]; then
        # info: https://docs.docker.com/engine/install/ubuntu/
        # Supported versions:
        #   Ubuntu Lunar 23.04
        #   Ubuntu Kinetic 22.10
        #   Ubuntu Jammy 22.04 (LTS)
        #   Ubuntu Focal 20.04 (LTS)
        #   Ubuntu Bionic 18.04 (LTS)

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
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        sudo chmod a+r /etc/apt/keyrings/docker.gpg
        
        # Set up the repository
        echo "Setting up the repository..."
        echo \
        "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        
        # Install docker
        echo "Installing docker..."
        sudo apt-get update
        sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    elif [[ "$OSTYPE" == "centos" ]]; then
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
    elif [[ "$OSTYPE" == "debian" ]]; then
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
    elif [[ "$OSTYPE" == "fedora" ]]; then
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
    else
        echo "Unsupported OS: $OSTYPE"
        echo "info: https://docs.docker.com/engine/install/#supported-platforms"
        exit 1
    fi
fi

# check if docker-compose is installed
echo "Checking if docker-compose is installed..."
if ! command -v docker-compose &> /dev/null
then
    echo "Installing docker-compose..."
    curl -SL https://github.com/docker/compose/releases/download/v2.18.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi

echo "Docker and docker-compose has been installed!"
