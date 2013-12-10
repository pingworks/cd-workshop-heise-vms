#!/bin/bash

# CD Workshop
# Shell Provisioner

# deploy env configuration
DEPLOY_ENV_HOSTNAME="cddemo"
DEPLOY_ENV_ENV="local01"
DEPLOY_ENV_DOMAIN_SUFFIX="cd-workshop-heise.net"

# Customization
CONFIG_INSTALL_X_DESKTOP=yes

MINIMAL_RECIPE_SET="base-all git-example-project java-oracle maven tomcat-local"
#MINIMAL_RECIPE_SET="tomcat-local"
#X_DESKTOP_RECIPE_SET=""
X_DESKTOP_RECIPE_SET="x-desktop"

RECIPES="${MINIMAL_RECIPE_SET}"
if [ "$CONFIG_INSTALL_X_DESKTOP"x = "yesx" ];then
  RECIPES="${RECIPES} ${X_DESKTOP_RECIPE_SET}"
fi    
  
echo "###################################################"
echo "# BEGIN Provisioning"
echo "###################################################"

echo "Checking Network Connectivity..."

set +e
PINGTEST=$(ping -c1 birk2.pingworks.net)
if [ $? -ne 0 ];then
  echo "ERROR: Host birk2.pingworks.net ist nicht erreichbar. Bitte ueberpruefen und Provisioning mit \"vagrant provision\" erneut starten!"
  exit 1
fi
set -e

[ -d /opt/chef ] && rm -R /opt/chef

echo "###################################################"
echo "# SETTING deploy env configuration"
echo "###################################################"

DEPLOY_ENV_CONFDIR=/home/vagrant/deploy-env-config
echo "Setting up DEPLOY_ENV_CONFDIR=${DEPLOY_ENV_CONFDIR}..."
[ ! -d ${DEPLOY_ENV_CONFDIR} ] && mkdir -p ${DEPLOY_ENV_CONFDIR} 

echo "${DEPLOY_ENV_HOSTNAME}" > ${DEPLOY_ENV_CONFDIR}/DEPLOY_ENV_HOSTNAME   
echo "${DEPLOY_ENV_ENV}" > ${DEPLOY_ENV_CONFDIR}/DEPLOY_ENV_ENV   
echo "${DEPLOY_ENV_DOMAIN_SUFFIX}" > ${DEPLOY_ENV_CONFDIR}/DEPLOY_ENV_DOMAIN_SUFFIX   

echo "###################################################"
echo "# Now provisioning..."
echo "###################################################"

[ -f /tmp/recipes_applied ] && rm /tmp/recipes_applied
touch /tmp/recipes_applied

for RECIPE in $RECIPES;do
  bash /vagrant/provision/recipes/$RECIPE/install.sh
  if [ $? -ne 0 ];then
     echo "ERROR: Provisioning with recipe $RECIPE fehlgeschlagen!"
     exit 1
  fi
  echo "$RECIPE" >> /tmp/recipes_applied
done

echo "###################################################"
echo "# END Provisioning"
echo "###################################################"
