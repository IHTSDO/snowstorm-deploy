#!/bin/bash

# Add config missing from 8.1.0
echo 'codesystem.config.SNOMEDCT-AT=Austrian Edition|11000234105|at|ELGA GmbH' | sudo tee -a /opt/snowstorm/application.properties
# Make Snowstorm user the owner of the installation directory
sudo chown -R snowstorm:snowstorm /opt/snowstorm

# Update memory settings in supervisor config
sudo sed -i 's/command.*/command = \/usr\/bin\/java -Xms4g -Xmx4g -Djava.security.egd=file:\/dev\/urandom -jar %(program_name)s.jar/g' /etc/supervisor/conf.d/snowstorm.conf

# Reload supervisor with new config
sudo supervisorctl reload

echo "Snowstorm will take about a minute to start. You can tail the log with this command:\n sudo supervisorctl tail -f snowstorm"
echo "Once started the native SNOMED CT API will be available at http://localhost:8080 the FHIR API will be available at http://localhost:8080/fhir"
echo "No terminologies or code systems are preloaded into the application."
