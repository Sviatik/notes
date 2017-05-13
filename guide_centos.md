    ifconfig eth0 172.16.25.125 netmask 255.255.255.224 broadcast 172.16.25.63
    route add default gw 192.168.99.254

    config VBox
    To overcome this error update gcc using

    1.yum update gcc

    2. yum update

    3. yum install kernel-uek-devel

    install sshfs
    sudo yum --enablerepo=epel install fuse-sshfs
    
    sshfs with pub-key
    sshfs centos@10.1.2.17:/home/centos/ /home/sviat/Desktop/sshfs_testkitchen -o IdentityFile=/home/sviat/sviat217.pem

    sshfs sviat@192.168.103.171:/home/sviat/ /home/sviat/Desktop/sshfs_ansible/


    yum install openssh-ldap.x86_64 

    bash autocomplite
    yum install epel-release.noarch bash-completion.noarch
    yum install bash-completion.noarch

    chkconfig sshd on - Autorun with startup

    ########################Настройка мережевих інтерфейсів#################################

    Настройка интерфейсов производится скриптом /etc/rc.d/init.d/network, который автоматически вызывается при переходе на 2, 3, 4 или 5 уровень выполнения. Скрипт network при вызове с параметром start поднимает интерфейсы, т.е. выполняет настройку и включение всех описанных интерфейсов, после чего настраивает статическую маршрутизацию.


    Описание интерфейсов находится в файлах ifcfg-* в каталоге /etc/sysconfig/network-scripts. В названии файла, за символом - следует имя интерфейса, например файл ifcfg-eth0 содержит настройки интерфейса eth0. Файл описания интерфейсов — это небольшой скрипт, содержащий только несколько команд присвоения variable=value где variable — определённый параметр настройки интерфейса, а value — необходимое значение этого параметра.

    Параметры интерфейса в файле ifcfg.

    DEVICE - Имя устройства
    ONBOOT - Нужно ли инициализировать интерфейс при загрузке (yes | no)
    BOOTPROT - При динамической настройке тип протокола, при помощи которого должен быть сконфигурирован интерфейс ( bootp | dhcp )
    BOOTP - Интерфейс необходимо настроить с использованием протокола удаленной загрузки BOOTP
    IPADDR - IP-адрес, который должен быть присвоен интерфейсу
    NETMASK - Маска подсети IP-адреса интерфейса
    NETWORK - Адрес сети интерфейса
    BROADCAST - Широковещательный адрес интерфейса

    Значения NETMASK, NETWORK, BROADCAST могут быть вычислены скриптом ifup автоматически при помощи программы ipcalc, поэтому, если они соответствуют классу IP-адреса, указывать явно их не обязательно
    Для настройки интерфейсов во время загрузки компьютера используется скрипт ifup, который принимает в качестве аргумента командной строки имя интерфейса interface.
    ifup interface
    Он читает конфигурационный файл interface или, если он отсутствует, файл из каталога /etc/sysconfig/networking/default. В крайнем случае, если не найден ни один из этих файлов читается конфигурация из ifcfg-interface. После этого скрипт производит настройку интерфейсов при помощи утилиты ip. Настраиваются не только интерфейсы сами по себе, но и необходимые маршруты для обращения к сетям, непосредственно доступным через интерфейс.
    Скрипты ifup и ifdown могут вызываться не только во время загрузки компьютера или при смене уровня выполнения, но и в ходе нормальной работы, когда нужно вручную поднять или опустить интерфейс.
    Перезапуск интерфейса eth0:
    # ifdown eth0
    # ifup eth0
    Файлы ifup и ifdown в каталоге /etc/sysconfig/network-scripts являются символическими ссылками на файлы ifup и ifdown в каталоге /sbin. Поэтому, при вызове вручную можно просто воспользоваться командами ifup и ifdown.
    При вызове в ходе начальной загрузки, скрипту ifup передается дополнительный аргумент boot, который сообщает, что интерфейс нужно поднимать только в том случае, если в файле его конфигурации параметр ONBOOT не установлен в no.

    Файл конфигурации eth0
    Вот пример наиболее распространённой конфигурации Ethernet-интерфейса:
    DEVICE=eth0
    ONBOOT=yes
    IPADDR=10.0.0.188
    NETMASK=255.255.255.0
    NETWORK=10.0.0.0
    BROADCAST=10.0.0.255

    В данном случае файл описывает интерфейс eth0, которому назначен IP-адрес из диапазона рекомендованного для локальных сетей 10.0.0.188. Поскольку адрес принадлежит классу A, а необходимо чтобы под сетевую часть было отведено 24 бита, явным образом задана сетевая маска NETMASK, адрес сети NETWORK и широковещательный адрес BROADCAST.
    /etc/init.d/network — Скрипт, выполняющий настройку сетевых интерфейсов и маршрутизации при загрузке.
    /etc/sysconfig/network — Конфигурационный файл, содержащий имя хоста, IP-адрес основного шлюза и IP-адреса основного и вспомогательного DNS-серверов
    /etc/sysconfig/network-scripts — Каталог, содержащий конфигурационные файлы интерфейсов и скрипты, выполняющие их инициализацию
    /etc/sysconfig/network-scripts/ifup — Скрипт, который выполняет настройку и активацию интерфейса
    /etc/sysconfig/network-scripts/ifdown — Скрипт, который выполняет деактивацию интерфейса
    /etc/sysconfig/network-scripts/ifcfg-* — Конфигурационные файлы, описывающие интерфейсы системы.


    ########################Настройка мережевих інтерфейсів#################################


    ########################Встановлення apache-maven + Java + envirenment variable#################################


    # tar -xvzf apache-maven-2.2.1.tar.gz
    # mv apache-maven-2.2.1/ /usr/local/
    # ln -s /usr/local/apache-maven-2.2.1/ /usr/local/maven

    # vim ~/.bashrc

    export M2_HOME=/usr/local/maven
    export PATH=${M2_HOME}/bin:${PATH}
    export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.25/jre

    # . ~/.bashrc

    # chmod +x /usr/local/maven/bin/mvn

    # mvn --version
    Apache Maven 2.2.1 (r801777; 2009-08-06 15:16:01-0400)
    Java version: 1.7.0_25
    Java home: /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.25/jre
    Default locale: en_US, platform encoding: UTF-8
    OS name: "linux" version: "2.6.32-358.el6.i686" arch: "i386" Family: "unix"
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
# Virtualbox guest additions

    yum install kernel-devel 
    yum install gcc* 
    yum install epel-release
    yum install dkms
    init 6    
    
    
    
    

## To enable users other than root and users with sudo access to be able to run Docker commands:

#Create the docker group:

    groupadd docker
    service docker restart
    
The UNIX socket /var/run/docker.sock is now readable and writable by members of the docker group.
Add the users that should have Docker access to the docker group:

    usermod -a -G docker user1
