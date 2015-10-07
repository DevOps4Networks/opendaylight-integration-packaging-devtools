#!/bin/bash
# Add suitable environment variables to .bashrc
echo "export MAVEN_OPTS=\"-Xmx1024m\"" >> ~odldev/.bashrc

# This value should ideally be a GB less than the RAM assigned to the VM itself.
echo "export JAVA_OPTS=\"-Xmx5120m\"" >> ~odldev/.bashrc

# Select a minimal profile for the Python client code
echo "export NETWORK_PROFILE=1-XRv" >> ~odldev/.bashrc
