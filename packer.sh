#!/bin/bash

rm -rf berks-cookbooks
rm -rf build
mkdir build
bundle install
bundle exec berks vendor -b chef/cookbooks/web-page-test/Berksfile
export PACKER_LOG=debug
packer build -only amazon-ebs packer.json
