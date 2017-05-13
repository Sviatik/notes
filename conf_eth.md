## Configure static ip for eth0

    ip route show | grep 'default' | awk '{print $5}'
    vi /etc/sysconfig/network-scripts/ifcfg-eth0
    DEVICE="eth0"
    NM_CONTROLLED="yes"
    ONBOOT=yes
    TYPE=Ethernet
    BOOTPROTO=static
    NAME="System eth0"
    UUID=5fb06bd0-0bb0-7ffb-45f1-d6edd65f3e03
    IPADDR=192.168.1.44
    NETMASK=255.255.255.0


## Configure Default Gateway

    vi /etc/sysconfig/network
    NETWORKING=yes
    HOSTNAME=centos6
    GATEWAY=192.168.1.1


## Restart Network Interface

    /etc/init.d/network restart

## Configure DNS Server

    vi /etc/resolv.conf
    nameserver 8.8.8.8      # Replace with your nameserver ip
    nameserver 192.168.1.1  # Replace with your nameserver ip


# linux
## Install and configure xen on Centos6.8
    yum install centos-release-xen
    yum update
    yum install xen
    reboot
    uname -r
    xl info


    ip route show | grep 'default' | awk '{print $5}'

## Configure network interface eth0:
    vi /etc/sysconfig/network-scripts/ifcfg-eth0
    DEVICE=eth0
    TYPE=Ethernet
    ONBOOT=yes
    NM_CONTROLLED=no
    BRIDGE=xenbr0


## Configure network interface xenbr0:
    vi /etc/sysconfig/network-scripts/ifcfg-xenbr0
    DEVICE=xenbr0
    BOOTPROTO=dhcp
    NM_CONTROLLED=no
    ONBOOT=yes
    TYPE=Bridge
    USERCTL=no
