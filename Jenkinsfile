pipeline {
    environment {
        ociCrdential = "${params.ocirCredential}"
        ociRegistry = "hyd.ocir.io/axvjenufkdre/bits-genai/genaiImage"
        dockerFile = "Dockerfile"
        dockerImage = ''
    }
    agent any

    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
                script {
                    dockerImage = docker.build("${ociRegistry}:${BUILD_NUMBER}", "-f ${dockerFile} .")
                   // bat "cmd /c docker build -t genaiImage:${BUILD_NUMBER}; "
                }                   
            }
        }
    }
    stages {
        stage('Push to OCIR') {
            steps {
                echo 'Hello World'
                script {
                    docker.withRegistry('http://hyd.ocir.io', ociCrdential)
                    dockerImage.Push
                }                   
            }
        }
    }
}
