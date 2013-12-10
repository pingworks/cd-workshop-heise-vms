#!/bin/bash
#
# please notice: all provisioning scripts have to be idempotent
#

. /vagrant/provision/config.sh
. /vagrant/provision/common.sh

set -e 
RECIPE='maven'

echo "# -------------------------------------------------"
echo "# BEGIN Provisioning RECIPE $RECIPE"
echo "# -------------------------------------------------"

apt-get --yes install maven

echo "# -------------------------------------------------"
echo "# END Provisioning RECIPE $RECIPE"
echo "# -------------------------------------------------"