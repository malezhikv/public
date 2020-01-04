#!/bin/bash
# inspired by https://gist.github.com/efeldhusen/4bea2031525203b1658b444f4709c12c (thanks!)
# curl -sL https://raw.githubusercontent.com/malezhikv/public/master/centos-template-prepare.sh | bash
#Paths are for Centos 7.x

#update
/usr/bin/yum update -y


#stop logging services
/sbin/service rsyslog stop
/sbin/service auditd stop


#remove old kernels
/usr/bin/package-cleanup --oldkernels --count=1 -y -q

#clean yum cache
/usr/bin/yum clean all

#force logrotate to shrink logspace and remove old logs as well as truncate logs
/usr/sbin/logrotate -f /etc/logrotate.conf
/bin/rm -f /var/log/*-???????? /var/log/*.gz
/bin/rm -f /var/log/dmesg.old
/bin/rm -rf /var/log/anaconda
/bin/cat /dev/null > /var/log/audit/audit.log
/bin/cat /dev/null > /var/log/wtmp
/bin/cat /dev/null > /var/log/lastlog
/bin/cat /dev/null > /var/log/grubby

#remove uuid from ifcfg scripts
/bin/sed -i '/^(HWADDR|UUID)=/d' /etc/sysconfig/network-scripts/ifcfg-eth0

#remove SSH host keys
/bin/rm -f /etc/ssh/*key*

#remove root users shell history
/bin/rm -f ~root/.bash_history
unset HISTFILE
history -c

poweroff
