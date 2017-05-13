# Mariadb Galera cluster

    На мастер ноді має бути в 
    wsrep_cluster_address=gcomm://
    пусто




### Truble shuting
    "[ERROR] WSREP: It may not be safe to bootstrap the cluster from this node. It was not the last one to leave the cluster and may not contain all the updates. To force cluster bootstrap with this node, edit the grastate.dat file manually and set safe_to_bootstrap to 1."

    /var/lib/mysql/grastate.dat

    safe_to_bootstrap: 1 
