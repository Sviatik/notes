#!/bin/bash


echo "############################################"
echo "###########START BOOTSTRAP SCRIPT###########"
echo "############################################"

#create user and add pub keys
useradd -m sviatik -g adm
mkdir /home/sviatik/.ssh
curl https://github.com/sviatik.keys >> /home/sviatik/.ssh/authorized_keys 

# Disable SELinux
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/sysconfig/selinux


yum upgrade
echo "INFO: START INSTAL PACKAGES"
yum install -y epel-release
yum install -y wget curl vim telnet bash-completion tmux openvpn




echo "############################################"
echo "############END BOOTSTRAP SCRIPT############"
echo "############################################"