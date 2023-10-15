## SF Project
This project utilizes Docker and Kubernetes for implementation. Both Task 1 and Task 2 are implemented using Docker. Furthermore, Task 2 is additionally implemented using Kubernetes.


**Description:**
The SF project consists of two tasks. The first task involves integrating LDAP with other services, such as a MySQL database, to enable users to authenticate across multiple services using a single password. The second task requires the development of a basic Twitter application that utilizes a MySQL database.



Task2  contains the following files:

tables.sql: This script contains the Data Definition Language (DDL) statements to create the relational tables for Twitter schema, along with the necessary constraints.

procedures.sql: This script includes various procedures that execute complex queries in our system.

tw_app.sh: This file serves as a user interface, allowing us to interact with the database through the command-line interface (CLI). It incorporates all the features implemented for our designed Twitter system.

**Requirements**

  **Task1**
  
   1 server1( Oracle Linux) for Docker host
   
   Installation Docker-compose


  **Task2**
  
   1 server1( Oracle Linux) for Master

   2 servers (Oracle Linux) for Workers


**Creating NFS storage provider For Provisioning **

#Install helm to install NFS-Client-Provisioner

wget -4 https://get.helm.sh/helm-v3.6.0-linux-amd64.tar.gz
tar -zxvf helm-v3.6.0-linux-amd64.tar.gz
sudo cp linux-amd64/helm /usr/local/bin/helm

#Install NFS Server - this might already be installed

```
sudo dnf install -y nfs-utils
```

Note: If you have another servers you should install nfs utilities
```
dnf install nfs-utils nfs4-acl-tools
```

#Enable service.
```
sudo systemctl enable --now nfs-server
```
#Create directory and set permissions
```
sudo mkdir /mnt/nfs
sudo chown nobody:nobody /mnt/nfs
sudo chmod 755 /mnt/nfs
```

#Set the export folder and IP Address, IP needs changing based on IP
```
echo '/mnt/nfs 172.17.0.0/16(rw,sync,no_subtree_check,no_root_squash)' | sudo tee -a /etc/exports
```

#Note: You should Add "no_root_squash" if you want to use MySQL pods:
```
chown: changing ownership of '/var/lib/mysql/': Operation not permitted
chown: changing ownership of '/var/lib/mysql': Operation not permitted
```

#Update exports
```
sudo exportfs -a
```
#Install NFS Provisioner from helm
```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=172.17.15.3 \   ### NFS IP Address
    --set nfs.path=/mnt/nfs          ### NFS storage Path
```
    
#Set NFS as default storage class

```
kubectl patch storageclass nfs-client -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

kubectl get storageclass
 
```
