# Python code
    #!/usr/bin/python
    from ansible.module_utils.basic import *
    import requests
    import simplejson as json

    def getphotopw(moduledata=False):
        headers = {moduledata['vaultheader']: moduledata['token']}
        r = requests.get(moduledata['address'] + moduledata['mount'], headers=headers)
        return r.json()
    def main():
        fields = { 
                "token": { "required"  : True , "type" : "str"  },
                "mount": { "required"  : True , "type" : "str"  },
                "address": { "required"  : True , "type" : "str" },
                "vaultheader": { "required"  : True , "type" : "str" }
                }
        module = AnsibleModule(argument_spec=fields)
        response = getphotopw(module.params)
        module.exit_json(changed=True, out=response , test=1)


    if __name__ == '__main__':  
        main()
        

in Short:
getphotopw it’s a simple function that accepts a dict as an argument , and creates a get requests against Vault
the main function defines the ansible plug-in add adds a dict of dicts with all the arguments that i will pass further down in the playbook
this is only a mock and needs a lot of work before hitting prod :)

Now the playbook looks like this:

    ---
    - hosts: all
      tasks:
        - name: "photodb library"
          photo:
            token: "a2300b3f-fc49-3b0b-b864-d4ea98775137"
            address: "http://localhost:8200/v1/"
            mount: "secret/photodb"
            vaultheader: "X-Vault-Token"
          register: photopw
        - debug:
            msg: "{{photopw['out']['data']['rootpw']}}"
        - name: "regenerate photo db"
          command: echo mysql -u root -p"{{photopw['out']['data']['rootpw']}}" photo < /tmp/photodb
          register: output
        - debug:
            msg: "{{output['stdout']}}"
