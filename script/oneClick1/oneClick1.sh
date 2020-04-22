#!/bin/bash


# ============ install docker and compose ===============
echo -e "\033[32m Install Docker and Docker Compose... \n \033[0m"
curl -L https://raw.githubusercontent.com/bugybq/ResourceHosting/master/script/oneClick1/docker_install.sh -o docker_install.sh
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
  rm docker_install.sh
  exit
fi

# ============ install portainer ===============
if [ $key_after_docker == "y" ];then
  rm docker_install.sh
  curl -L https://raw.githubusercontent.com/bugybq/ResourceHosting/master/script/oneClick1/portainer_install_swarm.sh \
    -o portainer_install_swarm.sh
  bash ./portainer_swarm_install.sh
fi

# ============ continue to install traefik? ===============
echo -e -n "\033[32m Continue to install traefik? [yes(y)/no(n)] :  \033[0m"
read key_after_portainer

while [ $key_after_portainer != "y" ] && [ $key_after_portainer != "n" ] 
do
  echo -e -n "\033[32m Continue to install traefik? [yes(y)/no(n)] :  \033[0m"
  read key_after_portainer
done

if [ $key_after_portainer == "n" ];then
  rm portainer_install_swarm.sh
  rm portainer-agent-stack.yml
  echo -e "\033[32m Access portainer with https://<yourdomain>:9000 \n \033[0m"
  exit
fi

# ============ install traefik ===============
if [ $key_after_portainer == "y" ];then
  rm docker_install.sh
  curl -L https://raw.githubusercontent.com/bugybq/ResourceHosting/master/script/oneClick1/traefik_install.sh \
    -o traefik_install.sh
  bash ./traefik_install.sh
fi

# ============ continue to install seafile? ===============
echo -e -n "\033[32m Continue to install seafile? [yes(y)/no(n)] :  \033[0m"
read key_seafile

while [ $key_seafile != "y" ] && [ $key_seafile != "n" ] 
do
  echo -e -n "\033[32m Continue to install traefik? [yes(y)/no(n)] :  \033[0m"
  read key_seafile
done

if [ $key_seafile == "n" ];then
  rm traefik_install.sh
  rm traefik.yml
  echo -e "\033[32m Access services with urls: \n \033[0m"
  echo -e "\033[32m   - portainer:  https://<portainer domain> \n \033[0m"
  echo -e "\033[32m   - traefik dashboard:  https://<traefik domain>/dashboard/ \n \033[0m"
  exit
fi

# ============ install seafile ===============
if [ $key_seafile == "y" ];then
  rm docker_install.sh
  curl -L https://raw.githubusercontent.com/bugybq/ResourceHosting/master/script/oneClick1/seafile_install.sh \
    -o seafile_install.sh
  bash ./seafile_install.sh
fi

# ============ continue to install Prometheus/Grafana for monitoring? ===============
echo -e -n "\033[32m Continue to install Prometheus/Grafana for monitoring? [yes(y)/no(n)] :  \033[0m"
read key_prom

while [ $key_prom != "y" ] && [ $key_prom != "n" ] 
do
  echo -e -n "\033[32m Continue to install Prometheus/Grafana for monitoring? [yes(y)/no(n)] :  \033[0m"
  read key_prom
done

if [ $key_prom == "n" ];then
  rm seafile_install.sh
  rm seafile.yml
  echo -e "\033[32m Access services with urls: \n \033[0m"
  echo -e "\033[32m   - portainer:  https://<portainer domain> \n \033[0m"
  echo -e "\033[32m   - traefik dashboard:  https://<traefik domain>/dashboard/ \n \033[0m"
  echo -e "\033[32m   - seafile:  https://<seafile domain> \n \033[0m"

  # ============ after seafile install notification ===============
  echo -e "\033[32m !!! Please logon https://<seafile domain> and replace \n \033[0m"
  echo -e "\033[32m   - SERVICE_URL \n \033[0m"
  echo -e "\033[32m   - FILE_SERVER_ROOT \n \033[0m"
  echo -e "\033[32m replace URLs with https://<seafile domain> \n \033[0m"

  exit
fi

# ============ install prometheus stack ===============
if [ $key_prom == "y" ];then
  rm docker_install.sh
  curl -L https://raw.githubusercontent.com/bugybq/ResourceHosting/master/script/oneClick1/seafile_install.sh \
    -o seafile_install.sh
  bash ./seafile_install.sh
fi