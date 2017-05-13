# OMS Project
## 1) Instal other sofware
    yum install vim
    yum install epel-release
    yum install wget
    yum install tmux
    
    
## 2) Install MVN JAVA TOMCAT
### Instal and configure Tomcat on Centos
   
    yum install tomcat
    yum install tomcat-webapps tomcat-admin-webapps
    yum install java-1.7.0-openjdk-devel.x86_64
    alternatives --config java
    
    
    wget ???
    tar -zxvf OMS.tar.gz
    
### Install mvn and java1.7
    
    cd /tmp/
    wget http://apache.ip-connect.vn.ua/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
    
    wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz"

    tar -zxvf jdk-7u79-linux-x64.tar.gz
    tar -xzf apache-maven-3.3.9-bin.tar.gz
    
    mv apache-maven-3.3.9 /usr/local/
    mv jdk1.7.0_79 /usr/local/

    ln -s /usr/local/apache-maven-3.3.9 /usr/local/maven
    ln -s /usr/local/jdk1.7.0_79 /usr/local/java




### vim ~/.bashrc
    export M2_HOME=/usr/local/maven
    export PATH=${M2_HOME}/bin:${PATH}
    export JAVA_HOME=/usr/local/java
    export PATH=${JAVA_HOME}/bin:${PATH}



### vim /usr/share/tomcat/conf/tomcat-users.xml
      <user username="admin" password="admin1" roles="manager-gui,manager-script,manager-jmx,manager-status,admin-gui,admin-script"/>

    </tomcat-users>

### Open 8080 port in firewall on centos 6.8
    iptables -I INPUT -p tcp -m tcp --dport 8080 -j ACCEPT
    service iptables save 

### Open 8080 port in firewall on centos 7
    firewall-cmd --zone=public --add-port=8080/tcp --permanent
    firewall-cmd --reload


## 3) Install MySQL-server on centos 6.8
    yum install mysql-server
    chkconfig mysqld on
    service mysqld start
    
    mysql -u root -p
    CREATE DATABASE _055_DB;
    SHOW DATABASES;
    CREATE user 'test'@'localhost' IDENTIFIED BY 'passwd';
    SELECT * from mysql.user; - (Перевірка юзерів)
    GRANT ALL ON _055_DB.* TO 'test'@'localhost';
    
   
    CREATE DATABASE _055_DB_Test;
    CREATE user 'oms'@'localhost' IDENTIFIED BY 'oms';
    GRANT ALL ON *.* TO 'test'@'localhost';
    
    
## 3.5) Install MySQL-server on centos 7

    rpm -ivh https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
    yum update
    sudo yum install mysql-server
    systemctl enable mysqld
    systemctl start mysqld
    grep 'temporary password' /var/log/mysqld.log
    mysql_secure_installation - пароль має бути 12символів великі маленькі 1 символ + 1 цифра
    
    set policy on mysql
    uninstall plugin validate_password;
    create user 'sviat'@'localhost' identified by 'pass';
    CREATE DATABASE _055_DB;
    SHOW DATABASES;
    GRANT ALL ON _055_DB.* TO 'sviat'@'localhost';
    FLUSH PRIVILEGES;
    

    
    
## 4) Edit 3 file on OMS
### Download true pom.xml and hibernate conf files
    cd OMS/
    rm -rf pom.xml
    wget https://github.com/Sviatik/java/raw/master/pom.xml

    cd OMS/src/main/webapp/WEB-INF/
    rm -rf hibernate.cfg.xml
    wget https://github.com/Sviatik/java/raw/master/hibernate.cfg.xml

    cd OMS/src/test/resources/
    rm -rf hibernate_test.cfg.xml
    wget https://github.com/Sviatik/java/raw/master/hibernate_test.cfg.xml
    

## 5) Build and deploy project
    maven clean install 
    cp OMS/target/OMS.war /usr/share/tomcat/webapps/

## 6) Export DB_dump in mysql-server:
    mysql -u user -p
    show databases;
    show table status from _055_DB;
    source /root/OMS/scripts/*.sql

    OR
    
    mysql -u user -p < OMS/scripts/addDate.sql
    
## 7) Run web app
    localhost:8080/OMS/
    
## 8) Drink beer
