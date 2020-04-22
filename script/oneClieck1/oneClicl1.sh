#!/bin/bash


# ============ install docker and compose ===============
echo -e "\033[32m Install Docker and Docker Compose... \n \033[0m"
curl -L https://raw.githubusercontent.com/bugybq/ResourceHosting/master/script/oneClieck1/docker_install.sh -o docker_install.sh
bash docker_install.sh

echo -e "\033[32m Docker/docker-compose installed... \n \n \033[0m"
echo -e -n "\033[32m Continue to install Portainer? [yes(y)/no(n)] :  \033[0m"
read key_after_docker

# ============ continue to install portainer? ===============
while [ $key_after_docker != "y" ] && [ $key_after_docker != "n" ] 
do
    echo -e -n "\033[32m Continue to install Portainer? [yes(y)/no(n)] :  \033[0m"
    read key_after_docker
done

# exit when 'n'
if [ $key_after_docker == "n" ];then
  exit
fi

# ============ install portainer ===============
if [ $key_after_docker == "y" ];then
  bash ./portainer_swarm_install.sh
fi

