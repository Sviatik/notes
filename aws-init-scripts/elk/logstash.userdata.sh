#!/bin/bash

echo "############################################"
echo "###########START BOOTSTRAP SCRIPT###########"
echo "############################################"

# Disable SELinux
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/sysconfig/selinux

yum upgrade
echo "INFO: START INSTAL PACKAGES"
yum install -y epel-release
yum install -y wget curl vim telnet bash-completion

echo "INFO: START INSTAL JAVA"
cd /tmp
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.rpm"
sudo yum -y localinstall jdk-8u161-linux-x64.rpm

sudo rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch


echo '[logstash-2.2]
name=logstash repository for 2.2 packages
baseurl=http://packages.elasticsearch.org/logstash/2.2/centos
gpgcheck=1
gpgkey=http://packages.elasticsearch.org/GPG-KEY-elasticsearch
enabled=1
' | sudo tee /etc/yum.repos.d/logstash.repo


sudo yum -y install logstash

systemctl start logstash
systemctl enable logstash





echo "############################################"
echo "############END BOOTSTRAP SCRIPT############"
echo "############################################"