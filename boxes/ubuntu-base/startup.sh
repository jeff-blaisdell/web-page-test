#!/bin/bash

# Update apt-get repo.
apt-get update

# Install Dependencies
apt-get -y install unzip
apt-get -y install build-essential
apt-get -y install ruby1.9.1-dev

# Install Ruby Bundler
gem install bundler

#sed -i 'vagrant   ALL = NOPASSWD: ALL' /etc/sudoers

# Install Docker
apt-get -y install docker.io
ln -sf /usr/bin/docker.io /usr/local/bin/docker
sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io

# Install Packer
mkdir /usr/local/packer
wget https://dl.bintray.com/mitchellh/packer/0.6.1_linux_386.zip
unzip 0.6.1_linux_386.zip -d /usr/local/packer
ln -sf /usr/local/packer/packer /usr/local/bin/packer
rm -f 0.6.1_linux_386.zip

cd /opt/web-page-test
./packer.sh
