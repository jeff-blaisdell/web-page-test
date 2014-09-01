#!/bin/bash

# Update apt-get repo.
sudo apt-get update

# Install Docker
sudo apt-get -y install docker.io
if [ ! -f '/usr/local/bin/docker' ]; then
    ln -sf /usr/bin/docker.io /usr/local/bin/docker
    sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io
    usermod -a -G docker ubuntu
fi

docker run -d -p 80:80 jeffblaisdell/web-page-test:0.1 /bin/sh -c "/usr/bin/supervisord -c /etc/supervisor/conf.d/apache2d.conf"
