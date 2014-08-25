#!/bin/bash

rm -rf berks-cookbooks
bundle install
bundle exec berks vendor -b chef/cookbooks/web-page-test/Berksfile
export PACKER_LOG=debug
packer build packer.json
