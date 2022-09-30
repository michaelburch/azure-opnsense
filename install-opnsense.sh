#!/bin/sh
set -e
OPNSENSE_VERSION="${3:-22.7}"
AZURE_AGENT_VERSION="${4:-2.8.0.11}"

# Fetch config and bootstrap script
BOOTSTRAP_URI="${1:-https://raw.githubusercontent.com/opnsense/update/$OPNSENSE_VERSION/src/bootstrap/opnsense-bootstrap.sh.in}"
CONFIG_URI="${2:-https://raw.githubusercontent.com/michaelburch/azure-opnsense/main/config/$OPNSENSE_VERSION-generic.xml}" 
echo "Retrieving $CONFIG_URI"
fetch $CONFIG_URI -o /usr/local/etc/config.xml

echo "Retrieving $BOOTSTRAP_URI"
fetch $BOOTSTRAP_URI

# Bootstrap
pkg install -y ca_root_nss
sed -i "" "s/reboot/# reboot/g" opnsense-bootstrap.sh.in
sh ./opnsense-bootstrap.sh.in -y -r $OPNSENSE_VERSION

# Azure Agent
fetch https://github.com/Azure/WALinuxAgent/archive/refs/tags/v$AZURE_AGENT_VERSION.tar.gz
tar -xvzf v$AZURE_AGENT_VERSION.tar.gz
cd WALinuxAgent-$AZURE_AGENT_VERSION/
python3 setup.py install --register-service --lnx-distro=freebsd --force
cd ..
ln -sf /usr/local/bin/python3.9 /usr/local/bin/python
sed -i "" 's/ResourceDisk.EnableSwap=y/ResourceDisk.EnableSwap=n/' /etc/waagent.conf

# Schedule Reboot
shutdown -r +1
exit 0