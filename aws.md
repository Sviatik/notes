# command
mount efs to ec2 instance

    sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 fs-e2f4382b.efs.eu-west-1.amazonaws.com:/ /mnt/


Instance metadata it\`s k/v storage:
    
    curl http://169.254.169.254/latest/meta-data
