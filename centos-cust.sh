#/bin/sh
echo "Upgrading packages"
yum update -y
yum install perl open-vm-tools net-tools yum-utils wget nano
echo "Stopping logging"
/bin/systemctl stop rsyslog.service
/sbin/service auditd stop
/bin/systemctl stop tuned.service
echo "Cleaning packages"
package-cleanup --oldkernels --count=1
package-cleanup --orphans
package-cleanup --problems
package-cleanup --leaves
yum clean all -y
echo "Removing logs"
cd /var/log/
rm -f *-2* *gz *old
rm -f anaconda* anaconda/*
rm -f audit/audit.log audit/*
rm -f tuned/*
rm -f tallylog
rm -f rhsm/rhsmcertd.log-*
rm -f rhsm/rhsm.log-*
rm -f sa/*
rm -f *.{1,2}
rm -f upstart/*gz
rm -f lynis*
rm -f vmware-tools-upgrader.log vmware-imc/toolsDeployPkg.log
find . -type f  | while read f; do > $f; done
find . -type f -ls
rm -f /var/log/*-???????? /var/log/*.gz
rm -f /var/log/dmesg.old
rm -rf /var/log/anaconda
cat /dev/null > /var/log/audit/audit.log
cat /dev/null > /var/log/wtmp
cat /dev/null > /var/log/lastlog
cat /dev/null > /var/log/grubby
rm -f /var/log/*-* /var/log/*.gz 2>/dev/null
rm -f /etc/sysconfig/network-scripts/ifcfg-*en*
rm -f /etc/udev/rules.d/70*
rm -f /var/lib/dhclient/*
rm -rf /tmp/*
rm -rf /var/tmp/*
rm -f /etc/ssh/*key*
echo "Changing hostname to localhost"
hostname localhost
echo "localhost" > /etc/hostname
rm -rf /root/.ssh/
rm -f /root/anaconda-ks.cfg
cd /root/
rm -fr .viminfo install.log.syslog install.log .ssh
echo "Removing bash history"
rm -f /root/.bash_history
rm -f /root/*.sh
unset HISTFILE
history -c
echo "Powering off! Bye-bye!"
history -c
exit
halt -p
