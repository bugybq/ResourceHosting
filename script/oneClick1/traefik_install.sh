#!/bin/bash

# ============ read traefik password ===============
echo -e -n "\033[32m Enter traefik dashboard user name : \033[0m"
read traefik_user

echo -e -n "\033[32m Enter traefik dashboard password : \033[0m"
read traefik_pass

echo $(htpasswd -nb $traefik_user $traefik_pass) | sed -e s/\\$/\\$\\$/g > pass

pass_string=$(cat pass)
rm pass

# ============ read domian and cert email ===============
echo -e -n "\033[32m Domain for traefik dashboard access: (e.g. traefik.mydomain.com) : \033[0m"
read traefik_domain

echo -e -n "\033[32m Email address for applying TLS certificates : \033[0m"
read traefik_email

# ============ update yml and toml file ===============
echo -e "\033[32m Installing traefik... \n \n \033[0m"

curl -L https://github.com/bugybq/ResourceHosting/blob/master/script/oneClick1/traefik_conf.toml -o traefik_conf.toml
curl -L https://github.com/bugybq/ResourceHosting/blob/master/script/oneClick1/traefik.yml -o traefik.yml

# sed -i 's/被替换的内容/要替换成的内容/' file        -i 直接修改并保存
sed -i "s/traefik_domain/$traefik_domain/g" traefik.yml
sed -i "s/pass_string/$pass_string/g" traefik.yml
sed -i "s/cert_email/$traefik_email/g" traefik_conf.toml

sudo mkdir -p /app_data/traefik/conf /app_data/traefik/conf/acme
sudo mv -f traefik_conf.toml /app_data/traefik/conf/traefik_conf.toml

sudo docker stack deploy --compose-file=traefik.yml ingress_traefik

echo -e "\033[32m traefik installed \n \n \033[0m"
echo -e "\033[32m traefik is activited as reverse proxy... \n \n \033[0m"