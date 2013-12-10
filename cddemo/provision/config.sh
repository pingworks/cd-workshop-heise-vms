#!/bin/bash

# CONFIGURATION
CONF_DUSER=heise
CONF_DGROUP=heise
CONF_DHOME=/home/$CONF_DUSER
CONF_PHOME=/vagrant/provision
CONF_VAGRANTREPO=http://birk2.pingworks.net/vagrant
CONF_GITHUB_EXAMPLE_PROJECT_URL=https://github.com/pingworks/cd-workshop-heise.git
CONF_VM_PROVISIONING_MODULE=cd-workshop-heise-vms
CONF_VM_PROVISIONING_MODULE_GITHUB_URL=https://github.com/pingworks/cd-workshop-heise-vms.git

DEPLOY_ENV_CONFDIR=/home/vagrant/deploy-env-config
for DEPLOY_ENV_CONFFILE in $(ls -1 $DEPLOY_ENV_CONFDIR); do
  TMPVALUE=$(cat $DEPLOY_ENV_CONFDIR/$DEPLOY_ENV_CONFFILE)
  #echo "DEBUG: Reading $DEPLOY_ENV_CONFFILE: $TMPVALUE"
  declare $DEPLOY_ENV_CONFFILE=$TMPVALUE
done
