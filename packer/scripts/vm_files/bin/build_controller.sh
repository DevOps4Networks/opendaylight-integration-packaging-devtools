#! /bin/bash

echo ***!!! This script will rebuild the controller. That could take hours. Are you sure you want to do that? !!!***

read -p "If so, press any key to continue, or Ctrl-c to quit ... " -n1 -s

echo " "

# Create directories for ODL build for the odldev user. If they already exist, then that's fine.
mkdir -p /home/odldev/git/odl-lithium
mkdir -p  /home/odldev/.m2
# Start by removing all snapshots to save space if the Maven repository is already populated
cd /home/odldev/.m2
find . -name "*SNAPSHOT*" -print -exec rm -rf {} \;

# Update Maven settings
cd /home/odldev/.m2
wget -q -O - https://raw.githubusercontent.com/opendaylight/odlparent/master/settings.xml > settings.xml
   
# Anonymous git clone for requierd ODL projects, based on 
# https://wiki.opendaylight.org/view/GettingStarted:Pulling,_Hacking,_and_Pushing_All_the_Code_from_the_CLI
# Just the integration project is required for a distribution
cd /home/odldev/git/odl-lithium
for PROJECT in integration; do git clone https://git.opendaylight.org/gerrit/${PROJECT}.git ${PROJECT}; done

# In case the code had already been cloned, do a git pull to make sure it is all up to date
for PROJECT in integration; do cd ${PROJECT}; git pull; cd /home/odldev/git/odl-lithium; done

# Git checkout stable branch for Lithium
for PROJECT in integration; do cd ${PROJECT}; git checkout stable/lithium; cd /home/odldev/git/odl-lithium; done

# Run Maven build and create Eclipse project files. Note that this build is configured not to fail, and to skip tets, which is suitable for running under automated circumstances on the Dev VM.
for PROJECT in integration; do cd ${PROJECT}; mvn -fn clean eclipse:eclipse install -D skipTests; cd /home/odldev/git/odl-lithium; done

# Import projects to Eclipse workspace (it would be nice if this did work, but it does not. TBD)
# mkdir -p /home/odldev/workspace
# /usr/local/eclipse-jee/eclipse -nosplash -data /home/odldev/workspace -application org.eclipse.cdt.managedbuilder.core.headlessbuild -importAll /home/odldev/git/odl-lithium

# Clean up projects to save space
# cd /home/odldev/git
# find . -name pom.xml -exec mvn clean -fn -f -nsu {} \; 

read -p "Done. Press any key to continue... " -n1 -s



