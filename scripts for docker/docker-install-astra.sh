#!/bin/bash

sudo apt update && apt upgrade

sudo apt-get install apt-transport-https ca-certificates curl gnupg2 

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

echo "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" | sudo tee -a /etc/apt/sources.list

sudo apt update

sudo apt install docker-ce

sudo curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo usermod -aG docker ${USER}

su - ${USER}
