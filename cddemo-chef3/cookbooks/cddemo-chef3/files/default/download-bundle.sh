#!/bin/bash

set -e 

REPOHOST=$1
BUNDLE=$2
if [ -z "$REPOHOST" -o -z "$BUNDLE" ]; then
  echo "Usage: $0 <repo host> <bundle id>"
  exit 1
fi

BUNDLEFILE="musicDB-bundle_${BUNDLE}.tar.gz"
BUNDLEURL="http://${REPOHOST}/repo/master/${BUNDLE}/bundles/${BUNDLEFILE}"

BASE=/var/bundle
echo "Cleaning up BASE: $BASE .."
rm -f ${BASE}/musicDB-bundle*.tar.gz
rm -rf ${BASE}/unpack/
mkdir ${BASE}/unpack
echo "done."

echo "Downloading bundle: $BUNDLEURL .."
wget -qO ${BASE}/${BUNDLEFILE} "$BUNDLEURL"
echo "done."

echo "Extracting bundle: $BUNDLEFILE .."
tar xfz ${BASE}/${BUNDLEFILE} -C ${BASE}/unpack
echo "done."

# run the installer
#if [ -x ${BASE}/unpack/artifacts/install.sh ]; then
#  echo "Running installer .."
#  /bin/bash ${BASE}/unpack/artifacts/install.sh
#  echo "done."
#fi  

