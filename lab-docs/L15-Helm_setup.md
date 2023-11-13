# Helm setup 

1. Install helm
   ```sh 
   curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
   chmod 700 get_helm.sh
   ./get_helm.sh
   ```
1. Validate helm installation 
   ```sh
   helm version
   helm list
   ```
1. [optional] Download .kube/config file to build the node 
   ```sh
   aws eks update-kubeconfig --region ap-south-1 --name ed-eks-01
   ```

1. Setup helm repo 
   ```sh 
   helm repo list
   helm repo add stable https://charts.helm.sh/stable
   given the repo name as' stable'
   helm repo list
   helm repo update
   helm search repo <helm-chart> for example 'helm search repo jenkins'
   helm search repo stable
   helm search repo mysql

   ```

1. Install mysql charts on Kubernetes 
   ```sh 
   helm install demo-mysql stable/mysql 
   'demo-mysql' is the helm cahrt name you want to give your local repo
   'stable/mysql' where its available

   ```
1. To pull the package from repo to local 
   ```sh 
   helm pull stable/mysql 
   This will pull all the manifest file into our system
   ```

  *Once you have downloaded the helm chart, it comes as a zip file. You should extract it.* 

  In this directory, you can find 
  - templates
  - values.yaml
  - README.md
  - Chart.yaml

  If you'd like to change the chart, please update your templates directory  and modify the version (1.6.9 to 1.7.0) in the chart.yaml
  'cat Chart.yaml' This will give you ther version of the helm chart

then you can run the command to pack it after your update
Change the service type of mysql to NodePort
```sh
 helm package mysql
```

To deploy helm chat
```sh 
 helm install mysqldb mysql-1.6.9.tgz
```

Above command deploy MySQL 
To check deployment 
```sh 
 helm list 
```
To uninstall 
```sh 
 helm uninstall mysqldb
```

To install nginx 
```sh 
 helm repo search nginx 
 helm install demo-nginx stable/nginx-ingress