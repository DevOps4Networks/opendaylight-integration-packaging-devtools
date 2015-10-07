#!/bin/bash
wget http://ftp.cixug.es/apache/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz
tar xf apache-maven-3.3.3-bin.tar.gz
mv apache-maven-3.3.3 /usr/local
echo "export MAVEN_HOME=/usr/local/apache-maven-3.3.3" >> ~odldev/.bashrc
echo "export PATH=\$MAVEN_HOME/bin:\$PATH" >> ~odldev/.bashrc
rm apache-maven-3.3.3-bin.tar.gz
