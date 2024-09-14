pipeline {
    environment {
        ociCrdential = "${params.ocirCredential}"
        ociRegistry = "hyd.ocir.io/axvjenufkdre/bits-genai/genaimage"
        dockerFile = "Dockerfile"
        dockerImage = ''
    }
    agent any

    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
                script {
                    //dockerImage = docker.build("${ociRegistry}:${BUILD_NUMBER}", "-f ${dockerFile} .")
                    bat "cmd /c docker images; "
                }                   
            }
        }
        stage('Push to OCIR') {
            steps {
                echo 'Hello World'
                script {
                    docker.withRegistry('https://hyd.ocir.io', ociCrdential)
                    dockerImage = docker.build("${ociRegistry}:${BUILD_NUMBER}", "-f ${dockerFile} .")
                    dockerImage.Push
                }                   
            }
        }
    }

}
