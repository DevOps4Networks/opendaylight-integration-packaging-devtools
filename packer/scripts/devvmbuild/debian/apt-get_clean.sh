#!/bin/bash
# Clean up after updating software on VM
sudo apt-get autoremove -y
sudo apt-get autoclean -y
sudo apt-get clean -y
