#!/bin/bash

# ============ create seafile folders ===============
sudo mkdir -p /app_data/seafile/data
sudo mkdir -p /app_data/seafile/db

# ============ get inputs ===============
wget https://raw.githubusercontent.com/bugybq/ResourceHosting/master/script/oneClick1/seafile.yml -O seafile.yml

echo -e -n "\033[32m Input mySQL DB password : \033[0m"
read mysql_pass

echo -e -n "\033[32m Input Admin email for logon : \033[0m"
read admin_email

echo -e -n "\033[32m Input Admin password : \033[0m"
read admin_pass

echo -e -n "\033[32m Domain for seafile access: (e.g. seafile.mydomain.com) : \033[0m"
read seafile_domain

# ============ update yaml ===============
sed -i "s/db_pass/$mysql_pass/g" seafile.yml
sed -i "s/admin@email.com/$admin_email/g" seafile.yml
sed -i "s/admin_pass/$admin_pass/g" seafile.yml
sed -i "s/seafile_domain/$seafile_domain/g" seafile.yml

# ============ install seafile ===============
echo -e "\033[32m Installing seafile ... \n \033[0m"
sudo docker stack deploy --compose-file=seafile.yml seafile



