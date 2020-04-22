#!/bin/bash
# install docker and docker-compose

# ============ apt update first ===============
echo -e "\033[32m apt update... \n \033[0m"
sudo apt-get update 

# ============ set timezone to Shanghai ===============
echo -e "\033[32m Set timezone to Asia/Shanghai... \n \033[0m"
sudo timedatectl set-timezone Asia/Shanghai

# ============ install htpasswd ===============
echo -e "\033[32m Install htpasswd to generate basic auth password... \n \033[0m"
# echo $(htpasswd -nb user password) | sed -e s/\\$/\\$\\$/g
sudo apt install -y apache2-utils

# ============ remove old docker installation ===============
echo -e "\033[32m Remove all old  docker installation... \n \033[0m"
sudo apt-get remove docker docker-engine docker.io containerd runc

# ============ Install docker ===============
echo -e "\033[32m Setup docker respository... \n \033[0m"

echo -e "\033[32m Setup apt over https... \n \033[0m"
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

echo -e "\033[32m Add Docker’s official GPG key... \n \033[0m"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo -e "\033[32m Setup the stable repository... \n \033[0m"
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo -e "\033[32m Instll docker version 5:19.03.8~3-0~ubuntu-bionic... \n \033[0m"
sudo apt-get update -y
sudo apt-get install -y docker-ce=5:19.03.8~3-0~ubuntu-bionic docker-ce-cli=5:19.03.8~3-0~ubuntu-bionic containerd.io

echo -e "\033[32m Add ubuntu user to docker group... \n \033[0m"
sudo usermod -aG docker ubuntu

# ============ Install docker-compose ===============
echo -e "\033[32m Download and install docker compose... \n \033[0m"

sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version

echo -e "\033[32m Apply current user to docker group (no need sodu for docker)... \n \033[0m"
#newgrp docker 