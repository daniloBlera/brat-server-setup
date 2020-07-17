#!/bin/bash
# Setup script for a BRAT annotator running on an Apache2 server
# Installing the required packages
sudo apt update && sudo apt upgrade
sudo apt install build-essential zip python2 python2-dev apache2

# Creating the /usr/bin/python symlink for python2.7
sudo ln -s /usr/bin/python2 /usr/bin/python

# Configuring the annotator
## Downloading and extracting the annotator files
[ -f 'brat-v1.3_Crunchy_Frog.tar.gz' ] || wget 'http://weaver.nlplab.org/~brat/releases/brat-v1.3_Crunchy_Frog.tar.gz'
tar xvf 'brat-v1.3_Crunchy_Frog.tar.gz'
mv 'brat-v1.3_Crunchy_Frog' "$HOME/brat-pages"

## Installing files
cd "$HOME/brat-pages"
./install.sh

# Configuring the pages for serving
## Changing ownership of the files
sudo chgrp -R "$(./apache-group.sh)" data work
chmod -R g+rwx data work

## Extracting and installing the json libs
cd server/lib/ && unzip ujson-1.18.zip && cd ujson-1.18 && python setup.py build && mv build/lib.*/ ../ujson

## Enabling user directories
sudo a2enmod userdir

## Configuring the user page for the annotator
cd "$HOME/brat-server-setup"
[ -f '/etc/apache2/mods-available/userdir.conf' ] && sudo mv /etc/apache2/mods-available/userdir.conf{,.bak}
sudo cp ./userdir.conf /etc/apache2/mods-available/

# Configuring the Apache server
## Enabling CGI resources loading
sudo ln -s /etc/apache2/mods-available/cgi.load /etc/apache2/mods-enabled/
sudo systemctl restart apache2.service
