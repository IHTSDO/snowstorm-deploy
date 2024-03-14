#!/bin/bash

# Elasticsearch must be installed before running this script.
# A server with 16g of RAM is recommended while importing and processing large RF2 files.
# This script installs the Snowstorm application with 4g of memory.

snowstorm_version=9.2.0

# Make script halt if anything goes wrong
set -e

# Install Java 11
sudo apt-get -y install openjdk-17-jre-headless

# Add repo
echo "deb [trusted=yes] https://maven3.ihtsdotools.org/repository/debian-releases/ bionic main" | sudo tee /etc/apt/sources.list.d/maven3_ihtsdotools_org_repository_debian_releases.list

# Update package manager
sudo apt-get update

# Install Snowstorm
sudo apt-get install -y snowstorm=${snowstorm_version}
# Make Snowstorm user the owner of the installation directory
sudo chown -R snowstorm:snowstorm /opt/snowstorm

# Update memory settings in supervisor config
sudo sed -i 's/command.*/command = \/usr\/bin\/java -Xms4g -Xmx4g -Djava.security.egd=file:\/dev\/urandom -jar %(program_name)s.jar/g' /etc/supervisor/conf.d/snowstorm.conf

# Reload supervisor with new config
sudo supervisorctl reload

echo "Snowstorm will take about a minute to start. You can tail the log with this command: sudo supervisorctl tail -f snowstorm"
echo "Once started the native SNOMED CT API will be available at http://localhost:8080 the FHIR API will be available at http://localhost:8080/fhir"
echo "No terminologies or code systems are preloaded into the application."
