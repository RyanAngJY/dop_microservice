pipeline {
    agent any

    stages {
        stage('Preparation') {
            steps{
                checkout scm  
            }
        }
        stage('docker build/push') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
                        docker.build("ryanang/dop_microservice:latest").push()
                    }   
                }
            }
        }
    }
}
