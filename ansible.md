# Ansible configuration

    file /etc/ansible/hosts - Дефолний файл конфігуряції який має в собі список хостів та груп хостів.
Можна задати змінною оточення $ANSIBLE_HOSTS
## Приклад    
    [dbservers]
    one.example.com
    two.example.com
    three.example.com

    [dnsservers]
    rs1.example.com ansible_ssh_port=5555 ansible_ssh_host=192.168.1.50
    rs2.example.com
    ns[01:50].example.com   






# OpenStack
    for create instance you must install python-shade
    yum install python-shade
    or
    yum install python-pip
    pip install shade
