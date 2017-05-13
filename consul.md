# consul
### Install on three node
    sudo yum install -y wget unzip net-tools git
    cd /tmp
    wget https://releases.hashicorp.com/consul/0.7.5/consul_0.7.5_linux_amd64.zip
    unzip consul_0.7.5_linux_amd64.zip
    sudo mv consul /usr/bin
    rm -rf consul_0.7.5_linux_amd64.zip

### Prepare on three node
    sudo mkdir /etc/consul.d
    sudo mkdir /var/lib/consul

### Run on master node
     consul agent -server -bootstrap-expect 1 -data-dir /var/lib/consul -config-dir /etc/consul.d &
     consul members                      # check node 


### Run on second node
    consul agent -data-dir /var/lib/consul -config-dir /etc/consul.d &
    consul join consul-master
    consul members                      # check node 


### Run on third node
    consul agent -data-dir /var/lib/consul -config-dir /etc/consul.d &
    consul join consul-master

    consul members                      # check node 





### necessary command
    consul monitor                      # Print in output log
    consul members                      # Print all node on cluster
    netstat -natp                       # print open port




### Troubleshooting
    # sudo consul
    # sudo: consul: command not found
    sudo ln -s /usr/local/bin/consul /usr/bin/consul

____________________________________

# Deploy Consul cluster
### Consul master node
    mkdir /tmp/consul
    consul agent -server -bootstrap-expect=1 -data-dir=/tmp/consul -node=agent-one -bind=(your ip on interface) \
    -config-dir=/etc/consul.d

    firewall-cmd --permanent --zone=public --add-port=8300/tcp
    firewall-cmd --reload



### Consul slave node
     mkdir /tmp/consul
     consul agent -data-dir=/tmp/consul -node=agent-two -bind=(your ip on interface) -config-dir=/etc/consul.d

     firewall-cmd --permanent --zone=public --add-port=8301/tcp
     firewall-cmd --reload

     consul join (ip master node or another node in cluster)

### Consul slave node
     mkdir /tmp/consul
     consul agent -data-dir=/tmp/consul -node=agent-three -bind=(your ip on interface) -config-dir=/etc/consul.d

     firewall-cmd --permanent --zone=public --add-port=8301/tcp
     firewall-cmd --reload

     consul join (ip master node or another node in cluster)



# Health check
    on second node
    echo '{"check": {"name": "ping",
    "script": "ping -c1 google.com >/dev/null", "interval": "30s"}}' \
    >/etc/consul.d/ping.json

    echo '{"service": {"name": "web", "tags": ["rails"], "port": 80,
    "check": {"script": "curl localhost >/dev/null 2>&1", "interval": "10s"}}}' >/etc/consul.d/web.json

    consul reload

# check health status on first node
    curl http://localhost:8500/v1/health/state/critical






__________________________________
# deploy web-ui
    cd /tmp
    mkdir /var/consul-ui
    wget https://releases.hashicorp.com/consul/0.7.5/consul_0.7.5_web_ui.zip
    unzip consul_0.7.5_web_ui.zip -d /var/consul-ui

### on master node
    consul agent -server -bootstrap-expect=1 -data-dir=/tmp/consul -node=agent-one -bind=192.168.103.201 -config-dir=/etc/consul.d -ui -client=0.0.0.0
            # -client - The address to which Consul will bind client interfaces, including the HTTP and DNS servers. Default - 127.0.0.1
            # -ui - Enables the built-in web UI server and the required HTTP routes. Default port - 8500. Starting with Consul version 0.7.0 and later, the Web UI assets are included in the binary file

    firewall-cmd --permanent --zone=public --add-port=8500/tcp
    firewall-cmd --reload

    
