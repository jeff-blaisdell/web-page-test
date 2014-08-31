#!/bin/bash

# Setup environment variables for Packer.
sed -i '$a AWS_USER_NAME='$1 /etc/environment
sed -i '$a AWS_ACCESS_KEY_ID='$2 /etc/environment
sed -i '$a AWS_SECRET_ACCESS_KEY='$3 /etc/environment
sed -i '$a DOCKER_USER_NAME='$4 /etc/environment
sed -i '$a DOCKER_PASSWORD='$5 /etc/environment
sed -i '$a DOCKER_EMAIL='$6 /etc/environment

# Update apt-get repo.
apt-get update

# Install Dependencies
apt-get -y install unzip
apt-get -y install build-essential
apt-get -y install apt-transport-https
apt-get -y install ruby1.9.1-dev

# Install Ruby Bundler
gem install bundler

#sed -i 'vagrant   ALL = NOPASSWD: ALL' /etc/sudoers

# Install Docker
apt-get -y install docker.io
if [ ! -f '/usr/local/bin/docker' ]; then
    ln -sf /usr/bin/docker.io /usr/local/bin/docker
    sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io
    usermod -a -G docker vagrant
fi

# Install Packer
if [ ! -d '/usr/local/packer' ]; then
    mkdir /usr/local/packer
    wget https://dl.bintray.com/mitchellh/packer/0.6.1_linux_386.zip
    unzip 0.6.1_linux_386.zip -d /usr/local/packer
    ln -sf /usr/local/packer/packer /usr/local/bin/packer
    rm -f 0.6.1_linux_386.zip
fi

# Kickoff Packer process to build web-page-test images.
#cd /opt/web-page-test
#su -c "source /opt/web-page-test/packer.sh" vagrant

# Locally install built image.
#cat /opt/web-page-test/build/web-page-test.tar | docker import - web-page-test

# Locally run docker image.
# docker run -d web-page-test /bin/sh -c "echo Launching Web Page Test container..."
# docker run -t -p 80:80 -i web-page-test /bin/bash
# docker run -t -i web-page-test /bin/bash
# docker run -t -i -p 80:80 web-page-test /bin/bash

