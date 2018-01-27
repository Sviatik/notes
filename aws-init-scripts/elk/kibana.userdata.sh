#!/bin/bash

echo "############################################"
echo "###########START BOOTSTRAP SCRIPT###########"
echo "############################################"

# Disable SELinux
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/sysconfig/selinux

yum upgrade

yum install epel-release

yum install wget curl vim telnet bash-completion

sudo rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch

echo '[kibana-4.4]
name=Kibana repository for 4.4.x packages
baseurl=http://packages.elastic.co/kibana/4.4/centos
gpgcheck=1
gpgkey=http://packages.elastic.co/GPG-KEY-elasticsearch
enabled=1
' | sudo tee /etc/yum.repos.d/kibana.repo



sudo yum -y install kibana


systemctl start kibana
systemctl enable kibana



echo "############################################"
echo "############END BOOTSTRAP SCRIPT############"
echo "############################################"