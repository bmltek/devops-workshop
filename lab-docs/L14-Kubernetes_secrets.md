## Integrate Jfrog with Kubernetes cluster
On the slave server go to
cd /opt/kubernetes
paste docker login https://bmltek.jfrog.io
Then give the 
Username: 
  
1. Create a dedicated user to use for a docker login   
go to jfrog 
     user menu --> new user  
     `user name`: jfrogcred  
     `email address`: logintoaws@gmail.com  
     `password`: <passwrod>  

2. To pull an image from jfrog at the docker level, we should log into jfrog using username and password   
```sh 
 docker login https://bmltek.jfrog.io
 Userbname: 'my email'
 Password: "my password"
```

3. genarate encode value for ~/.docker/config.json file 
  ```sh 
   cat ~/.docker/config.json | base64 -w0
   copy the output and keep in notepad
   go to secret.yaml file and replace the  '.dockerconfigjson' with the output you copy.
   ```
   
`Note:` For more refer to [Kuberentes documentation](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/)  
Make sure secret value name `regcred` is updated in the deployment file.  

  `copy auth value to encode`
  cat ~/.docker/config.json | base64 -w0
  `use above command output in the secret`

copy the manifestfile into the source code repo.
run 
git add --chmod=+x deploy.sh
git add deploy.sh
```
