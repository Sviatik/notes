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


echo '[logstash-2.2]
name=logstash repository for 2.2 packages
baseurl=http://packages.elasticsearch.org/logstash/2.2/centos
gpgcheck=1
gpgkey=http://packages.elasticsearch.org/GPG-KEY-elasticsearch
enabled=1
' | sudo tee /etc/yum.repos.d/logstash.repo


sudo yum -y install logstash







echo "############################################"
echo "############END BOOTSTRAP SCRIPT############"
echo "############################################"