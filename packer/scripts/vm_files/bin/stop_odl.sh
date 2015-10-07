#! /bin/bash
echo ***!!! This script will stop ODL. Are you sure you want to do that? !!!***

read -p "Press any key to continue, or Ctrl-c to quit... " -n1 -s

echo " "
echo " "

/home/odldev/git/odl-lithium/integration/distributions/karaf/target/assembly/bin/stop

echo This script will pause for 30 seconds and then check status
sleep 30

echo " "

/home/odldev/git/odl-lithium/integration/distributions/karaf/target/assembly/bin/status

echo " "

read -p "Done. Press any key to continue... " -n1 -s

