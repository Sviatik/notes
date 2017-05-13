#!/bin/bash


echo -e "INFO: add epel repository"

yum -y upgrade

echo -e "INFO: add epel repository"

yum -y install epel-release
yum -y update
