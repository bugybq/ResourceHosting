#!/bin/bash

# ============ enable docker swarm mode ===============
# initialize docker swarm...
echo -e "\033[32m Initializing ... \n \033[0m"
docker swarm init


# ============ create new docker network for between app communication ===============
# create docker network app_net...
echo -e "\033[32m Creating docker network "app_net" \n \033[0m"
docker network create \
  --driver=overlay \
  --subnet=172.33.0.0/16 \
  --gateway=172.33.0.1 \
  app_net

# ============ install portainer ===============
# deploy portainer stack...
echo -e "\033[32m Installing portainer \n \033[0m"
curl -L https://raw.githubusercontent.com/bugybq/ResourceHosting/master/script/portainer-agent-stack.yml -o portainer-agent-stack.yml

echo -n "domain for portainer dashboard access: (e.g. portainer.mydomain.com)"
read portainer_domain
sed -i "s/portainer_domain/$portainer_domain/g" portainer-agent-stack.yml

docker stack deploy --compose-file=portainer-agent-stack.yml portainer
