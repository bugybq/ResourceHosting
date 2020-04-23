# Content

## About

Convenient installation script for self-hosting apps on docker/docker swarm.
Application included:

- Docker environment
- Portainer for docker environment management
- Traefik as ingress/reverse proxy
- Seafile as personal online storage
- Prometheus/Grafana for server/docker monitoring

## Prerequisite

- Ubuntu 18
- 4 different domain names point to the same ip (each installed service must have unique domain name)

## Installation

```bash
wget https://raw.githubusercontent.com/bugybq/ResourceHosting/master/script/oneClick1/oneClick1.sh -O oneClick1.sh
bash oneClick1.sh

```

port 8000,9000


chown -R 472 grafana
chown -R 65534 prometheus
