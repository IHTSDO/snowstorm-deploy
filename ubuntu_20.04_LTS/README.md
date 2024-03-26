# Snowstorm Deployment Scripts for **Ubuntu 20.04 LTS**

- Install Elasticsearch: [install_elasticsearch.sh](install_elasticsearch.sh)
- Install Snowstorm (including Java 17): [install_snowstorm.sh](install_snowstorm.sh)

Run these using:
```
bash <(curl -s https://raw.githubusercontent.com/IHTSDO/snowstorm-deploy/main/ubuntu_20.04_LTS/install_elasticsearch.sh )
bash <(curl -s https://raw.githubusercontent.com/IHTSDO/snowstorm-deploy/main/ubuntu_20.04_LTS/install_snowstorm.sh )
```
Snowstorm will start on HTTP port 8080.

---

To enable Snowstorm access on port 80 using Nginx: [install_nginx.sh](install_nginx.sh)

Run this using:
```
bash <(curl -s https://raw.githubusercontent.com/IHTSDO/snowstorm-deploy/main/ubuntu_20.04_LTS/install_nginx.sh )
```
