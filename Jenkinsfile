pipeline {
    agent any

    stages {
        stage('docker build/push') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-registry-credentials	') {
                        docker.build("ryanang/dop_microservice:latest").push()
                    }   
                }
            }
        }
    }
}
