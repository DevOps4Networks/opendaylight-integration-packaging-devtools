#! /bin/bash
set -e

echo ***!!! This will start the ODL server that you have built from git. Are you sure you want to do that? !!!***

echo " "

read -p "Press any key to continue, or Ctrl-c to quit ... " -n1 -s

echo " "
echo " "

cp /home/odldev/git/odl-lithium/integration/distributions/karaf/target/assembly/etc/org.apache.karaf.features.cfg /home/odldev/git/odl-lithium/integration/distributions/karaf/target/assembly/etc/org.apache.karaf.features.cfg.bak
cp /home/odldev/Desktop/odl.cfg /home/odldev/git/odl-lithium/integration/distributions/karaf/target/assembly/etc/org.apache.karaf.features.cfg

nohup /home/odldev/git/odl-lithium/integration/distributions/karaf/target/assembly/bin/start

echo " "

echo "This script will pause for 30 seconds and then check status"

sleep 30

/home/odldev/git/odl-lithium/integration/distributions/karaf/target/assembly/bin/status

echo " "

echo "You should wait a few minutes for ODL to start up properly before trying to use it."

echo " "

read -p "Done. Press any key to continue... " -n1 -s

