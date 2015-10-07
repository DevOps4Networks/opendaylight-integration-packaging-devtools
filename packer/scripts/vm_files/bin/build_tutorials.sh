#! /bin/bash

echo ***!!! This script will rebuild the tutorials. That could take hours. Are you sure you want to do that? !!!***

echo " "

read -p "If so, press any key to continue, or Ctrl-c to quit ... " -n1 -s

echo " "

# Create directories for ODL build for the odldev user. If they already exist, then that's fine.
mkdir -p /home/odldev/git/coretutorials
mkdir -p  /home/odldev/.m2
# Start by removing all snapshots to save space if the Maven repository is already populated
cd /home/odldev/.m2
find . -name "*SNAPSHOT*" -print -exec rm -rf {} \;

# Update Maven settings
cd /home/odldev/.m2
wget -q -O - https://raw.githubusercontent.com/opendaylight/odlparent/master/settings.xml > settings.xml

# Git clone the ODL core tutorials
cd /home/odldev/git
git clone https://git.opendaylight.org/gerrit/p/coretutorials.git
    
# Build core tutorials
cd /home/odldev/git/coretutorials
# mvn -fn -nsu clean eclipse:eclipse install
# The build from top level does not seem to work reliably, so go into each chapter and build each one seperately
find . -name pom.xml -exec mvn clean install -D skipTests -fn -f {} \; 

# Clean up projects to save space
# cd /home/odldev/git
# find . -name pom.xml -exec mvn clean -fn -f -nsu {} \; 

echo " "

read -p "Done. Press any key to continue... " -n1 -s



