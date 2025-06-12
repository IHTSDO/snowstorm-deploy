#!/bin/bash

# The data store of Snowstorm version 10.x is Elasticsearch version 8.11.x, or a later 8.x version.
# A server with 16g of RAM is recommended while importing and processing large RF2 files.
# This script installs Elasticsearch 8.11.4 assigning 4g of memory.

elasticsearch_version=8.11.4

# Make script halt if anything goes wrong
set -e

# Add Elastic.co package signing key
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg

# Update package manager
sudo apt update

# Install required HTTPS transport
sudo apt-get install apt-transport-https

# Add Elastic.co package repository
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" \
| sudo tee /etc/apt/sources.list.d/elastic-8.x.list

# Update package manager again
sudo apt update

# Install Elasticsearch
sudo apt install -y elasticsearch=${elasticsearch_version}

# Set config options in temp file
echo -e "network.host: localhost\nxpack.security.enabled: false\n" > tmp.txt

# Copy in remaining config
sudo grep -v 'xpack.security.enabled' /etc/elasticsearch/elasticsearch.yml >> tmp.txt

# Replace config file without changing file permissions
cat tmp.txt | sudo tee /etc/elasticsearch/elasticsearch.yml

# Set JVM options in temp file
echo -e "-Xms4g\n-Xmx4g\n" > tmp.txt

# Strip existing memory settings from default options
sudo cat /etc/elasticsearch/jvm.options | grep -v '\-Xm' >> tmp.txt

# Replace JVM options file without changing file permissions
cat tmp.txt | sudo tee /etc/elasticsearch/jvm.options

# Update service manager
sudo systemctl daemon-reload

# Enable automatic start in service manager
sudo systemctl enable elasticsearch.service

# Start Elasticsearch
sudo systemctl start elasticsearch


curl localhost:9200
