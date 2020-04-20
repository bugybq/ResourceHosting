echo -e "\033[32m apt update \n \033[0m"
sudo apt-get update 

echo -e "\033[32m Set timezone to Asia/Shanghai \n \033[0m"
sudo teimdatectl set-timezone Asia/Shanghai

echo -e "\033[32m Install htpasswd to generate basic auth password \n \033[0m"
# echo $(htpasswd -nb user password) | sed -e s/\\$/\\$\\$/g
sudo apt install -y apache2-utils



echo -e "\033[32m remove old all docker installation \n \033[0m"
sudo apt-get remove docker docker-engine docker.io containerd runc


echo -e "\033[32m setup docker respository \n \033[0m"

echo -e "\033[32m setup apt over https \n \033[0m"
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

echo -e "\033[32m Add Docker’s official GPG key \n \033[0m"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo -e "\033[32m set up the stable repository \n \033[0m"
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo -e "\033[32m instll docker version 5:19.03.8~3-0~ubuntu-bionic \n \033[0m"
sudo apt-get update
sudo apt-get install -y docker-ce=5:19.03.8~3-0~ubuntu-bionic docker-ce-cli=5:19.03.8~3-0~ubuntu-bionic containerd.io

echo -e "\033[32m add ubuntu user to docker group \n \033[0m"
sudo usermod -aG docker ubuntu

echo -e "\033[32m please logout and login back \n \033[0m"
