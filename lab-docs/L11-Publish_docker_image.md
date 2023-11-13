## Build and Publish a Docker image 
1. Install docker on jenkinsslave system
2. Create a Dockerfile
3. Create a docker repository in jfrog
4. install 'docker pipeline' jfrog
5. Update Jenkinsfile with docker build and publish stage1.    

1. Write and add dockerfile in the source code
	```sh
		FROM openjdk:8
		ADD jarstaging/com/valaxy/demo-workshop/2.1.2/demo-workshop-2.0.2.jar demo-workshop.jar
		ENTRYPOINT ["java", "-jar", "demo-workshop.jar"]
	```
   `Check-point:`  version number in pom.xml and dockerfile should match   
1. Create a docker repository in the Jfrog  
    repository name: valaxy-docker
1. Install `docker pipeline` plugin 

1. Update Jenkins file with the below stages  
# https://bmltek01.jfrog.io/artifactory/bml-docker/
    ```sh 
	   def imageName = 'bmltek.jfrog.io/bml-docker-local/ttrend'
	   def version   = '2.1.2'
        stage(" Docker Build ") {
          steps {
            script {
               echo '<--------------- Docker Build Started --------------->'
               app = docker.build(imageName+":"+version)
               echo '<--------------- Docker Build Ends --------------->'
            }
          }
        }

                stage (" Docker Publish "){
            steps {
                script {
                   echo '<--------------- Docker Publish Started --------------->'  
                    docker.withRegistry(registry, 'artifact-cred'){
                        app.push()
                    }    
                   echo '<--------------- Docker Publish Ended --------------->'  
                }
            }
        }
    ```

Check-point: 
1. Provide jfrog repo URL in the place of `bmltek.jfrog.io/bml-docker` in `def imageName = 'bmltek.jfrog.io/valaxy-docker/ttrend'`  
2. Match version number in `def version   = '2.1.2'` with pom.xml version number  
3. Ensure you have updated credentials in the field of `artifact-cred` in `docker.withRegistry(registry, 'artifactory_token'){`

Note: make sure docker service is running on the slave system, and docker should have permissions to /var/run/docker.sock