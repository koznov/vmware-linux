#/bin/bash
apt update -y && apt-upgrade -y
apt install open-vm-tools net-tools perl -y
/etc/init.d/rsyslog stop
/etc/init.d/atd stop
apt-get autoclean
apt-get clean
apt-get autoremove
logrotate –f /etc/logrotate.conf
cd /var/log/
rm -f *-2* *gz *old
rm -f apt/*
rm -f audit/audit.log audit/*
rm -f *.{1,2}
rm -f vmware-tools-upgrader.log vmware-imc/toolsDeployPkg.log
find . -type f  | while read f; do > $f; done
find . -type f -ls
rm –f /var/log/*-???????? /var/log/*.gz
rm -f /var/log/dmesg.old
cat /dev/null > /var/log/audit.log
cat /dev/null > /var/log/wtmp
cat /dev/null > /var/log/lastlog
rm -f /var/log/*-* /var/log/*.gz 2>/dev/null
rm -f /etc/udev/rules.d/70*
rm –rf /tmp/*
rm –rf /var/tmp/*
rm –f /etc/ssh/*key*
hostname localhost
echo "localhost" > /etc/hostname
rm -rf ~root/.ssh/
cd ~root
rm -fr .viminfo install.log.syslog install.log .ssh
cd /home
rm -f */{.bash_history}
rm -f */*.sh
rm -f ~root/.bash_history
unset HISTFILE
history -c
halt -p
