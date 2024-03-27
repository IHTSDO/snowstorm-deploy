#!/bin/bash

# Make script halt if anything goes wrong
set -e

# Install the Nginx webserver to allow Snowstorm access from port 80
sudo apt-get -y install nginx

# Remove the dummy "Welcome  to Nginx" website
sudo rm -rf /etc/nginx/sites-enabled/default

# Add Nginx config for Snowstorm
curl 'https://raw.githubusercontent.com/IHTSDO/snowstorm-deploy/main/ubuntu_20.04_LTS/snowstorm-nginx.conf' | sudo tee /etc/nginx/conf.d/snowstorm.conf

# Start Nginx
sudo nginx
