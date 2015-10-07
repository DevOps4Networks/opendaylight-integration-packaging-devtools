#!/bin/bash
# Reconfigure VMware tools after software update 
service vmware-tools stop
cd /home/vagrant/vmware-tools-distrib/bin 
./vmware-config-tools.pl -d
service vmware-tools restart
