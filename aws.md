# command
mount efs to ec2 instance

    sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 fs-e2f4382b.efs.eu-west-1.amazonaws.com:/ /mnt/


Instance metadata it\`s k/v storage:
    
    curl http://169.254.169.254/latest/meta-data



### Json output

    aws ec2 describe-security-groups --group-names MySecurityGroup

    {
    "SecurityGroups": [
        {
            "IpPermissionsEgress": [],
            "Description": "My security group",
            "IpPermissions": [
                {
                    "PrefixListIds": [],
                    "FromPort": 22,
                    "IpRanges": [
                        {
                            "CidrIp": "203.0.113.0/24"
                        }
                    ],
                    "ToPort": 22,
                    "IpProtocol": "tcp",
                    "UserIdGroupPairs": []
                }
            ],
            "GroupName": "MySecurityGroup",
            "OwnerId": "123456789012",
            "GroupId": "sg-903004f8",
        }
    ]
}



# Step to create new env
- Add new VPC
- Edit DNS hostnames in VPS
- Add subnet per availability zone
- Add new GW
- In Route Table add default getaway (0.0.0.0/0) to new GW
- Add or create new SSH key.
- Add SG