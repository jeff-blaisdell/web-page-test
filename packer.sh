#!/bin/bash

rm -rf berks-cookbooks
rm -rf build
mkdir build
bundle install
bundle exec berks vendor -b chef/cookbooks/web-page-test/Berksfile

# Login to docker account to allow push to docker-hub.
docker login -u $DOCKER_USER_NAME -p $DOCKER_PASSWORD -e $DOCKER_EMAIL
export PACKER_LOG=debug
packer build -only docker packer.json
