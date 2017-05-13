# Vault Hashicorp ©  
![](https://chocolatey.org/content/packageimages/vault.0.6.5.png)
## Install vault
    sudo yum install -y wget unzip
    cd /tmp
    wget https://releases.hashicorp.com/vault/0.6.5/vault_0.6.5_linux_amd64.zip
    unzip vault_0.6.5_linux_amd64.zip
    sudo mv vault /usr/bin
    rm -rf vault_0.6.5_linux_amd64.zip
 
    vault -v                    # check vault

## Run dev server (for testing) (Only one machine)
    vault server -dev &
    ...
        export VAULT_ADDR='http://127.0.0.1:8200'
        Unseal Key: TMLDq8am0WrnQcJE+8HuMnk+rmyrKrUIBTyjvo8KzRM=
        Root Token: d236457d-421d-6926-ab55-7f1e05e1c674
    ...
    export VAULT_ADDR='http://127.0.0.1:8200'
    vault status                        
        Sealed: false
        Key Shares: 1
        Key Threshold: 1
        Unseal Progress: 0
    ...
## Auth to root user
    vault auth d236457d-421d-6926-ab55-7f1e05e1c674     # Root Token
## Create secret
    vault write secret/oms/db base=_055_DB login=mysql password=mysql524297
        # write credentials for db

    vault list secret                       # check directory
    vault read secret/oms/db                # check K/V
    Key                 Value
    ---                 -----
    refresh_interval    768h0m0s
    base                _055_DB
    login               mysql
    password            mysql524297

### Change login
    vault write secret/oms/db login=change_user excited=yes
    vault read -format=json secret/oms/db | jq -r .data.login
        change_user

### Delete secret
    vault delete secret/oms/db

## Work with json
    wegt https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64
    chmod +x jq-linux64
    mv jq-linux64 /usr/local/bin/jq

    vault read -format=json secret/oms/db | jq

    vault read -format=json secret/oms/db | jq -r .data
    vault read -format=json secret/oms/db | jq -r .data.base
    vault read -format=json secret/oms/db | jq -r .data.login

## Mount beckend secret
    vault mounts                # check mount beckend secret
    vault mount generic         
    vault unmount generic


## Create dynamic secret
    vault mount aws
    vault write aws/config/root \
        access_key=AKIAI4SGLQPBX6CSENIQ \
        secret_key=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

### Creating a role (policy)
    cat > policy.json
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "Stmt1426528957000",
          "Effect": "Allow",
          "Action": [
            "ec2:*"
          ],
          "Resource": [
            "*"
          ]
        }
      ]
    }
    Ctr+C
    vault write aws/roles/deploy policy=@policy.json   
            # use special syntax @filename to write the content of a file.
    vault read aws/creds/deploy
    Key         Value
    lease_id    aws/creds/deploy/0d042c53-aa8a-7ce7-9dfd-310351c465e5
    access_key  AKIAJFN42DVCQWDHQYHQ
    secret_key  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

### Revoking the secret
    vault revoke aws/creds/deploy/0d042c53-aa8a-7ce7-9dfd-310351c465e5


## Create token
    vault token-create
        Key             Value
        ---             -----
        token           29904bab-47f2-b7ac-ce47-58131a56ba47
        token_accessor  1e5b9602-97c1-795c-1578-b401ea07bd0a      
            # accessor - you can interact to token use by token_accessor 
                (revake, update, add policy). like :
            $vault token-revoke --accessor b30ee2a3-ea4b-9da0-3e5c-4189d375cad9

________________________________________________________________

# Deploy Vault
### Pre stup (install consul)
    yum install -y wget unzip net-tools
    cd /tmp
    wget https://releases.hashicorp.com/consul/0.7.5/consul_0.7.5_linux_amd64.zip
    unzip consul_0.7.5_linux_amd64.zip
    mv consul /usr/local/bin
    rm -rf consul_0.7.5_linux_amd64.zip
### Run consul
    consul agent -server -bootstrap-expect 1 -data-dir /tmp/consul -bind 127.0.0.1 &
### necessary command 
    consul monitor                      # Print in output log
    consul members                      # Print all node on cluster
    netstat -natp                       # print open port


### Config
    cat > example.hcl
    backend "consul" {
      address = "127.0.0.1:8500"
      path = "vault"
    }

    listener "tcp" {
     address = "127.0.0.1:8200"
     tls_disable = 1
    }
    Ctr+C

    export VAULT_ADDR='http://127.0.0.1:8200'
    vault server -config=example.hcl
    vault init

    $VAULT_TOKEN - env var root token
    export VAULT_TOKEN=dsajn22e329fn3fn93ufn393                  
