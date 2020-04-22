#!/bin/bash

# ============ create prom folders ===============
sudo mkdir -p /app_data/monitor/prometheus
sudo mkdir -p /app_data/monitor/alertmanager
sudo mkdir -p /app_data/monitor/grafana/provisioning
mkdir -p ./prom/alertmanager ./prom/prometheus \
  ./prom/grafana/provisioning/datasources ./prom/grafana/provisioning/dashboards  \

# ============ get inputs ===============
curl -L https://raw.githubusercontent.com/bugybq/ResourceHosting/master/script/oneClick1/portainer-agent-stack.yml -o ./prom/portainer-agent-stack.yml

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
docker stack deploy --compose-file=seafile.yml seafile



