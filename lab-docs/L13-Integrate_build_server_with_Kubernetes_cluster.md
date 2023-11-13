## Integrate build server with Kubernetes cluster 

1. Setup kubectl  
# install kubectl on Jenkins slave 
   ```sh 
   # copy the kubectl version that meet your eks version
     curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.24.9/2023-01-11/bin/linux/amd64/kubectl
     chmod +x ./kubectl or chmod +x kubectl
     mv kubectl /usr/local/bin
     kubectl version
   ``` 

1. Make sure you have installed awscli latest version. If it has awscli version 1.X then remove it and install awscli 2.X  
# install awscli
    ```sh 
     yum remove awscli 
     curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
     apt install unzip
     unzip awscliv2.zip
     sudo ./aws/install
    ```

1. Configure awscli to connect with aws account  
    ```sh 
     aws configure
     Provide access_key, secret_key
    ```

1. Download Kubernetes credentials and cluster configuration (.kube/config file) from the cluster  

   ```sh 
    aws eks update-kubeconfig --region us-east-1 --name valaxy-eks-01
   ```
go to the Jenkins-slave server
cd /opt
mkdir kubernetes 
cd kubernetes
add all the files in the Kubernetes folder

