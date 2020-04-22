#!/bin/bash

# ============ create seafile folders ===============
sudo mkdir -p /app_data/seafile/data
sudo mkdir -p /app_data/seafile/db

# ============ get inputs ===============
curl -L https://raw.githubusercontent.com/bugybq/ResourceHosting/master/script/seafile.yml -o seafile.yml

echo -n -e "\n Input mySQL DB password: "
read mysql_pass

echo -n -e "\n Input Admin email for logon: "
read admin_email

echo -n -e "\n Input Admin password: "
read admin_pass

echo -n -e "\n input domain name for seafile: "
read seafile_domain

# ============ update yaml ===============
sed -i "s/db_pass/$mysql_pass/g" seafile.yml
sed -i "s/admin@email.com/$admin_email/g" seafile.yml
sed -i "s/admin_pass/$admin_pass/g" seafile.yml
sed -i "s/seafile_domain/$seafile_domain/g" seafile.yml

# ============ install seafile ===============
echo -e "\033[32m Installing seafile ... \n \033[0m"
docker stack deploy --compose-file=seafile.yml seafile

# ============ after install notification ===============
echo -e "\033[32m Please logon $seafile_domain and replace \n \033[0m"
echo -e "\033[32m   - SERVICE_URL \n \033[0m"
echo -e "\033[32m   - FILE_SERVER_ROOT \n \033[0m"
echo -e "\033[32m replace URLs to $seafile_domain \n \033[0m"


