#!/bin/bash


echo "############################################"
echo "###########START BOOTSTRAP SCRIPT###########"
echo "############################################"


# Disable SELinux
#setenforce 0
#sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/sysconfig/selinux


yum upgrade
echo "INFO: START INSTAL PACKAGES"
yum install -y epel-release
yum install -y wget curl vim telnet bash-completion tmux


systemctl start elasticsearch
systemctl enable elasticsearch


echo "############################################"
echo "############END BOOTSTRAP SCRIPT############"
echo "############################################"