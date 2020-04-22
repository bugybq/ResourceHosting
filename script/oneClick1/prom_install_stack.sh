#!/bin/bash

# ============ create prom folders ===============
sudo mkdir -p /app_data/monitor/
#sudo mkdir -p /app_data/monitor/prometheus
#sudo mkdir -p /app_data/monitor/alertmanager
#sudo mkdir -p /app_data/monitor/grafana/provisioning
mkdir -p ./prom/alertmanager ./prom/prometheus \
  ./prom/grafana/provisioning/datasources ./prom/grafana/provisioning/dashboards  \

# ============ downloads lots of files ===============
wget https://raw.githubusercontent.com/bugybq/ResourceHosting/master/script/oneClick1/prom-stack.yml -O prom-stack.yml
sudo apt instll wget -y
wget https://raw.githubusercontent.com/bugybq/ResourceHosting/master/script/oneClick1/prom_config/list.txt -q -O list.txt
wget -i list.txt -P ./prom -q
mv ./prom/config.yml ./prom/alertmanager/config.yml
mv ./prom/dashboard.yml ./prom/grafana/provisioning/dashboards/dashboard.yml
mv ./prom/DockerPrometheusMonitoring-1571332751387.json ./prom/grafana/provisioning/dashboards/DockerPrometheusMonitoring-1571332751387.json
mv ./prom/datasource.yml ./prom/grafana/provisioning/datasources/datasource.yml
mv ./prom/config.monitoring ./prom/grafana/config.monitoring
mv ./prom/alert.rules ./prom/prometheus/alert.rules
mv ./prom/prometheus.yml ./prom/prometheus/prometheus.yml

# ============ get grafana domain and password ===============
echo -e -n "\033[32m Domain for grafana : (e.g. monitor.mydomain.com) : \033[0m"
read grafana_domain
echo -e -n "\033[32m Set your grafana password : \033[0m"
read grafana_pass
sed -i "s/grafana_domain/$grafana_domain/g" prom-stack.yml
sed -i "s/grafana_pass/$grafana_pass/g" ./prom/grafana/config.monitoring

# ============ move all config files to /app_data ===============
mv ./prom/* /app_data/monitor/

# ============ set folder permissions for grafana and prometheus ===============
chown -R 472 ./app_data/monitor/grafana
chown -R 65534 ./app_data/monitor/prometheus

# ============ install seafile ===============
echo -e "\033[32m Installing prometheus stack ... \n \033[0m"
sudo docker stack deploy --compose-file=prom-stack.yml monitor

echo -e "\033[32m Prometheus stack installed... \n \033[0m"

