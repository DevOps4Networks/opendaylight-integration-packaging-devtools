#!/bin/bash
# The latest version with OpenFlow support is 1.12.x which needs a repository added. See:
# http://linuxg.net/how-to-install-wireshark-1-12-4-on-ubuntu-15-04-ubuntu-14-10-ubuntu-14-04-ubuntu-12-04-and-derivative-systems-via-ppa/

add-apt-repository ppa:pi-rho/security -y
apt-get update -y

# The install runs dpkg-configure, so we need to make sure that it is not run interactively
# http://unix.stackexchange.com/questions/96215/feeding-input-values-to-dpkg-reconfigure-in-non-interactive-way
echo "debconf debconf/frontend select noninteractive" | sudo debconf-set-selections

# and we have to preset the required values, with a hint from
# http://www.microhowto.info/howto/perform_an_unattended_installation_of_a_debian_package.html
echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections

# Install wireshark
apt-get install wireshark wireshark-doc -y

# Set up groups and permissions so that the odldev user can listen on all interfaces and ports.
# The dpkg-configure run during the install should create the wireshark group and configure dumpcap
# as required, in case it does not the required commands are commented out below.

#groupadd --system wireshark
usermod -a -G wireshark odldev
#chgrp wireshark /usr/bin/dumpcap
#chmod 750 /usr/bin/dumpcap
#setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap
