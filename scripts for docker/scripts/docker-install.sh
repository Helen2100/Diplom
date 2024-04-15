#18.03.2024

#!/bin/bash

sudo apt -y update && apt -y upgrade

sudo apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common


version=$(cat /etc/issue)

if [[ .*$version.* =~ .*"Astra".* ]]; then
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    echo "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" | sudo tee -a /etc/apt/sources.list
fi

if [[ .*$version.* =~ .*"Mint".* ]]; then
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    echo "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" | sudo tee -a /etc/apt/sources.list
fi

if [[ .*$version.* =~ .*"Debian".* ]]; then
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
fi

if [[ .*$version.* =~ .*"Ubuntu".* && .*$version.* =~ .*"20.04".* ]]; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
fi

if [[ .*$version.* =~ .*"Ubuntu".* && .*$version.* =~ .*"22.04".* ]]; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
fi

sudo apt update

sudo apt install -y docker-ce

sudo usermod -aG docker ${USER}

su - ${USER}

# lsb_release -a

