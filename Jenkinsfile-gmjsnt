pipeline{
    
    agent any 
    
    stages {
        
        stage('Git Checkout'){
            
            steps{
                
                script{
                    
                    git branch: 'main', credentialsId: 'GitID', url: 'https://github.com/shreemansandeep/demo-counter-app.git'
                }
            }
        }
        stage('UNIT testing'){
            
            steps{
                
                script{
                    
                    sh 'mvn test'
                }
            }
        }
        stage('Integration testing'){
            
            steps{
                
                script{
                    
                    sh 'mvn verify -DskipUnitTests'
                }
            }
        }
        stage('Maven build'){
            
            steps{
                
                script{
                    
                    sh 'mvn clean install'
                }
            }
        }
        stage('Static code analysis'){
            
            steps{
                
                script{
                    
                    withSonarQubeEnv(credentialsId: 'sonartoken') {
                        
                        sh 'mvn clean package sonar:sonar'
                    }
                   }
                    
                }
            }
            stage('Quality Gate Status'){
                
                steps{
                    
                    script{
                        
                        waitForQualityGate abortPipeline: false, credentialsId: 'sonartoken'
                    }
                }
            }  
        
        stage('Upload War To Nexus'){
            steps{
                  nexusArtifactUploader artifacts: [
                       [
                            artifactId: 'springboot', 
                            classifier: '', 
                            file: "target/Uber.war", 
                            type: 'war'
                       ]
                  ], 
                  credentialsId: 'nexus-auth', 
                  groupId: 'com.example', 
                  nexusUrl: '13.233.197.251:8081', 
                  nexusVersion: 'nexus3', 
                  protocol: 'http', 
                  repository: 'demoapp-release', 
                  version: '3.0.0'  
              }
            }
        
        stage("deploy-dev"){
            steps{
                sshagent(['tomcat-pipedp']) {
                sh """
                    scp -o StrictHostKeyChecking=no target/Uber.war ubuntu@172.31.33.156:/opt/tomcat/webapps/
                    ssh ubuntu@172.31.33.156 /opt/tomcat/bin/shutdown.sh
                    ssh ubuntu@172.31.33.156 /opt/tomcat/bin/startup.sh
                
                """
            }
            
            }
        } 
        
        }
        
}
