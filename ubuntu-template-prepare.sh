#!/bin/bash
######################################################
#### WARNING PIPING TO BASH IS STUPID: DO NOT USE THIS
######################################################
# modified from: jcppkkk/prepare-ubuntu-template.sh
# TESTED ON UBUNTU 18.04 LTS / 20.04 LTS

# SETUP & RUN
# curl -sL https://raw.githubusercontent.com/malezhikv/public/master/ubuntu-template-prepare.sh | sudo -E bash -

if [ `id -u` -ne 0 ]; then
	echo Need sudo
	exit 1
fi

set -v

#update apt-cache
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y upgrade

#Stop services for cleanup
service rsyslog stop

#clear audit logs
if [ -f /var/log/wtmp ]; then
    truncate -s0 /var/log/wtmp
fi
if [ -f /var/log/lastlog ]; then
    truncate -s0 /var/log/lastlog
fi

#cleanup /tmp directories
rm -rf /tmp/*
rm -rf /var/tmp/*

#cleanup current ssh keys
rm -f /etc/ssh/ssh_host_*

#add check for ssh keys on reboot...regenerate if neccessary
cat << 'EOL' | tee /etc/rc.local
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.
# dynamically create hostname (optional)

test -f /etc/ssh/ssh_host_rsa_key || dpkg-reconfigure openssh-server
exit 0
EOL

# make sure the script is executable
chmod +x /etc/rc.local

#reset hostname
truncate -s0 /etc/hostname
hostnamectl set-hostname localhost

#cleanup apt
apt clean

# set dhcp to use mac - this is a little bit of a hack but I need this to be placed under the active nic settings
# also look in /etc/netplan for other config files
sed -i 's/optional: true/dhcp-identifier: mac/g' /etc/netplan/50-cloud-init.yaml

# generate random root password
echo "root:$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo '')" | chpasswd

#cleanup shell history
cat /dev/null > ~/.bash_history
history -c
exit
#shutdown
#shutdown -h now
