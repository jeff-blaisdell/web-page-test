Web Page Test
=============

A private Web Page Test server instance created with [Chef]/[Vagrant]/[Docker]/[Packer].

## Getting Started

#### Install Vagrant
Head on over to [Vagrant] and install a version compatible with your system.  This should be the only software required to run this project.  Other dependencies will be automatically installed into a vagrant environment.

#### Setup Amazon EC2
Before you begin you'll need to create an Amazon AWS IAM account.  We'll use the account details to help automate the deploy of a Web Page Test server to EC2.  For more information on Amazon IAM setup checkout [Creating an IAM User in Your AWS Account]

#### Setup Docker
You will also need a Docker Hub account.  See [Docker Hub] for details.  We'll use Docker Hub as a repository for our Web Page Test machine images.

#### Setup Environment Variables
You'll need to create the following environment variables in your system.  The variables will need to be available to command line scripts.  For example, I run zsh on osx - so I define my environment vars in ~/.zshenv
```
# Amazon EC2 IAM Variables
export AWS_USER_NAME="XXXX"
export AWS_ACCESS_KEY_ID="XXXX"
export AWS_SECRET_ACCESS_KEY="XXXX"
export AWS_KEYPAIR_NAME="XXXX"

# Docker Hub Variables
export DOCKER_USER_NAME="XXXX"
export DOCKER_PASSWORD="XXXX"
export DOCKER_EMAIL="XXXX"
```

#### Building a Web Page Test Image
```
# Change directory into ubuntu-base.
cd ~/Git/web-page-test/boxes/ubuntu-base

# Start vagrant.  This should download and install an Ubuntu box with the necessary software.
vagrant up

# After box has been created let's ssh into box to build our docker image.
vagrant ssh

# Change directory into the web-page-test directory.
cd /opt/web-page-test

# Kickoff Packer.  This will build a Docker image with all necessary software and push artifact for Docker Hub.
./packer.sh
```

## Directory Structure

* **boxes** *~ Vagrant VMs*
    * **ubuntu-aws**
    
        *A vagrant wrapper around an Ubuntu AWS EC2 instance.  Running 'vagrant up' will launch an Ubuntu container running in Amazon's EC2 service.*
    * **ubuntu-base**
    
        *An Ubuntu VM that can be used to build and install a machine image of a Web Page Test server.* 
* **chef**

    *Contains all configuration used to build a Web Page Test server.*
* **packer.json**
 
    *Packer configuration file used to generate a web page test server image.*

* **packer.sh**

    *A little shell wrapper to kick off packer process.*


## Tooling Introduction

### Chef
Chef is a Ruby based tool for configuration management.  You utilize Chef to automate the creation of your infrastructure.  This is typically accomplished by creating Ruby scripts, called recipes, that build various pieces of your architecture.  For example, you could create a recipe to build an Apache web server, and another recipe to install and run your application as a service.  To help you get started Chef has a vast marketplace of ready made recipes to get you up and running.

### Vagrant
Vagrant is a tool that helps to manage virtual machines.  With a simple command 'vagrant up' Vagrant can automatically create a virtualized Ubuntu container and install any necessary software all in minutes.  You are not limited to Ubuntu, but pretty much any OS is supported - including Amazon EC2.

### Docker
Docker serves two primary purposes.  First, it allows you to create portable virtualized containers that can hold your application and relevant dependencies.  These containers are isolated from the underlying OS and each other.  The second primary benefit of Docker is it allows a created container to easiliy be converted into an image which can then be quickly installed on other servers.

### Packer
Managing the inter-dependendecies of a Chef / Vagrant / Docker ecosystem can get a little tricky.  Packer provides some glue to help bundle these technologies to aid in building machine images.

[Chef]:https://www.getchef.com/chef/
[Vagrant]:https://www.vagrantup.com/about.html
[Docker]:https://www.docker.com/whatisdocker/
[Packer]:http://www.packer.io/
[Creating an IAM User in Your AWS Account]:http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_SettingUpUser.html
[Docker Hub]:https://hub.docker.com/
