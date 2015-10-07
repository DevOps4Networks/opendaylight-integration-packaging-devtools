# Install Mininet
mkdir -p /home/odldev/git/mininet-packages
cd /home/odldev/git/mininet-packages
git clone git://github.com/mininet/mininet
cd mininet
git checkout -b 2.2.1d2 2.2.1d2
util/install.sh -a
chown -R odldev /home/odldev/git
