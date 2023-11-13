## SonarQube Configuration 
1. create an account  at https://sonarcloud.io
2. Generate an authentication token on SonarQube
3. Create credentials for token in the Jenkins
4. Download "SonarQube scanner" plugins on Jenkins
5. Configure SonarQube server
6. Add SonarQube scanner to jenkins
7. Create SonarQube Properties file
8. Add SonarQube stage in the Jenkinsfile

1. Create Sonar cloud account on https://sonarcloud.io
2. Generate an Authentication token on SonarQube
    Account --> my account --> Security --> Generate Tokens 

3. On Jenkins create credentials 
   Manage Jenkins --> manage credentials --> system --> Global credentials --> add credentials
 - Credentials type: `Secret text`
 - ID: `sonarqube-key`

4. Install SonarQube plugin
    Manage Jenkins --> Available plugins 
    Search for `sonarqube scanner`

5. Configure sonarqube server 
   Manage Jenkins --> Configure System --> sonarqube server 
   Add Sonarqube server 
   - Name: `sonar-server`
   - Server URL: `https://sonarcloud.io/`
   - Server authentication token: `sonarqube-key`

6. Configure sonarqube scanner 
   Manage Jenkins --> Global Tool configuration --> Sonarqube scanner 
   Add sonarqube scanner 
   - Sonarqube scanner: `sonar-scanner`
7. Create SonarQube Properties file
google sonarqube properties file.
Go tohttps://docs.sonarsource.com/sonarqube/latest/analyzing-source-code/scanners/sonarscanner/
-   Go to Configure your project
-   create sonar-project.properties in our root directory
- go to sonarcloud account - my account - Organizations - create - creat an organization manually 
name = bml
key = bml-key
choose plan = free - create Organization
When preparing the sonar-project.properties : sonar.organzation=bmltek-key . This should be the organization key.

- My project - Analyze new project
    - Display Name = twittertrend
    Project key = bml-key_twittertrend
    Project visibility = public
    The new code for this project will be based on: Previous version
    create project
    go to information to get the project information.
complete the sonar-project.properties and save it in the source-code repo in GitHub

8. Add SonarQube stage in the Jenkinsfile
google Jenkins Extention for sonarqube - https://docs.sonarsource.com/sonarqube/10.1/analyzing-source-code/scanners/jenkins-extension-sonarqube/#maven-or-gradle

- go to SonarScanner for maven
-copy the stage "SonarQube analysis" and paste to Jenkinsfile.
go to your Jenkins server - manage jenkins - tools -sonarqube scanner- copy name and use it to edit the jenkinsfile stage.
    def scannerHome = tool 'bml-sonar-scanner'
Define the above under environment.
environment{
            scannerHome = tool 'bml-sonar-scanner'
        }
Replace 'My SonarQube Server' to servername (Go to jenkins - manage jenkins - system - sonaqube installation server name = sonaqube-server)
# Adding unit test stage to Jenkinsfile
Add stage after build and name it 'test'
# Adding quality Gate
To create quality gate- click on the organization name - create Quality Gate - name 'bml-java-QG' - add condition - where "on overall code" - Quality Gate fails when 'type Bugs' - Operator " greater than 50" then we fail our builds - Quality Gate fails when 'Code Smells' - Operator " greater than 50"
# Apply the quality Gate to projects
project - click on the project name - Administration -quality gate - select the quality gate you added to the organization
# Adding Quality Gate to Jenkinsfile
Copy the quality stage syntax in the documentation.Add it as a new stage after sonarqube analysis stage

