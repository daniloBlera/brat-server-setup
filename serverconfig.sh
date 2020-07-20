#!/bin/bash
# Obs.: Using 'bash' instead of 'dash' due to some brace expansions
#
# Setup script for a BRAT annotator running on an Apache2 server
# Installing the required packages
sudo apt update && sudo apt upgrade
sudo apt install build-essential zip python2 python2-dev apache2

# Creating the /usr/bin/python symlink for python2.7
sudo ln -s /usr/bin/python2 /usr/bin/python

# Extracting the datasets
mkdir BioNLP-2019
find . -type f -name '*_BB-rel_*.zip' -exec unzip -d 'BioNLP-2019/BB-Rel' {} ';'
find . -type f -name '*_BB-norm_*.zip' -exec unzip -d 'BioNLP-2019/BB-Norm' {} ';'
cp {annotation,visual}.conf 'BioNLP-2019/BB-Rel/'

# Configuring the annotator
## Downloading and extracting the annotator files
[ -f 'brat-v1.3_Crunchy_Frog.tar.gz' ] || wget 'http://weaver.nlplab.org/~brat/releases/brat-v1.3_Crunchy_Frog.tar.gz'
tar xvf 'brat-v1.3_Crunchy_Frog.tar.gz'
mv 'brat-v1.3_Crunchy_Frog' "$HOME/brat-pages"

## Install files
cd "$HOME/brat-pages"
./install.sh

## Copy the datasets
cp -r "$HOME/brat-server-setup/BioNLP-2019" 'data/'

## Merge '.a1' and '.a2' into a '.ann' annotation files
find data -name '*.a1' -o -name '*.a2' -o -name '*.rel' -o -name '*.co' | tools/merge.py

## Convert relation notation -- Overwriting the generated '.ann' files only
## The dataset contains relations with the format
##
##		ID RELATION ENTITY1:ID1 ENTITY2:ID2
##
## But the annotator requires
##
##		ID RELATION Arg1:ID1 Arg2:ID2
##
## So the relations (on the generated '.ann' files)
##
##		ID Lives_In Microorganism:ID1 Location:ID2
##		ID Exhibits Microorganism:ID1 Property:ID2
##
## Will be converted to
##
##		ID Lives_In Arg1:ID1 Arg2:ID2
##		ID Exhibits Arg1:ID1 Arg2:ID2
find data -type f -name '*.ann' -exec sed -i -e 's/Microorganism:/Arg1:/g' -e 's/Location:/Arg2:/g' -e 's/Property:/Arg2:/g' {} \;

## Configure the pages for serving -- Fix file ownership
sudo chgrp -R "$(./apache-group.sh)" data work
chmod -R g+rwx data work

## Extract and install the json libs
cd server/lib/ && unzip ujson-1.18.zip && cd ujson-1.18 && python setup.py build && mv build/lib.*/ ../ujson

## Enable user directories
sudo a2enmod userdir

## Configure the user page for the annotator
cd "$HOME/brat-server-setup"
[ -f '/etc/apache2/mods-available/userdir.conf' ] && sudo mv /etc/apache2/mods-available/userdir.conf{,.bak}
sudo cp ./userdir.conf /etc/apache2/mods-available/

# Configuring the Apache server
## Enabling CGI resources loading
sudo ln -s /etc/apache2/mods-available/cgi.load /etc/apache2/mods-enabled/
sudo systemctl restart apache2.service
