
pipeline {
    agent any
    environment {
        ECR_REPO = '339712936703.dkr.ecr.ap-south-1.amazonaws.com/config-server'
        AWS_CREDENTIALS_ID = 'aws-ecr-credentials'
        GIT_CREDENTIALS_ID = 'gitJenkins'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: 'main']],  
                          userRemoteConfigs: [[url: 'https://github.com/gauravgorde/config-server.git',
                                               credentialsId: 'gitJenkins']]])
            }
        }
        
        stage('Maven Build') {
            steps {
                dir('/var/lib/jenkins/workspace/Spring-Config') {
                    sh 'mvn clean compile'
                }
            }
        }
        
        stage('Deploy') {
            steps {
                sh "mvn package"
            }
        }
        
        stage('Build Doc Img') {
            steps {
                sh 'docker build -t gmgorde123/configserver:8000 .'
            }
        }
        
        stage('Docker Login') {
            steps {
                withCredentials([string(credentialsId: 'DockerID', variable: 'Dockerpwd')]) {
                    sh "docker login -u gmgorde123 -p gmgorde123"
                }
            }
        }
        
        stage('Docker Push') {
            steps {
                sh 'docker push gmgorde123/configserver:8000'
            }
        }
        
        stage('Docker Deploy') {
            steps {
                sh 'docker run -d -p 8000:8000 gmgorde123/configserver:8000'
            }
        }
        
        stage('Archiving') {
            steps {
                archiveArtifacts '**/target/*.jar'
            }
        }
    }
}
