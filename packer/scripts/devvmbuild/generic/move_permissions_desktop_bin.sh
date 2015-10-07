#!/bin/bash
# Move provisioned files into place and set ownership and permissions
mkdir -p ~odldev/Desktop
mkdir -p ~odldev/bin
mkdir -p ~odldev/.config/google-chrome/Default

mv ~vagrant/Desktop/* ~odldev/Desktop
chmod 755 ~odldev/Desktop/*

mv ~vagrant/bin/*.sh ~odldev/bin
chmod 755 ~odldev/bin/*.sh

mv ~vagrant/Chrome_Bookmarks ~odldev/.config/google-chrome/Default/Bookmarks
chown odldev ~odldev/.config/google-chrome/Default/Bookmarks
chmod 755 ~odldev/.config/google-chrome/Default/Bookmarks

chown -Rf odldev:odldev ~odldev
