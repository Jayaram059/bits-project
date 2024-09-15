pipeline {
    environment {
        ociCrdential = "${params.ocirCredential}"
        ociRegistry = "hyd.ocir.io/axvjenufkdre/bits-genai/genaimage"
        dockerFile = "Dockerfile"
        dockerImage = ''
    }
    agent {
        node {
            label  'jayaramslave'
    }

    }


    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'                 
            }
        }
        stage('Push to OCIR') {
            steps {
                echo 'Hello World'
                script {
                    sh """alias docker="sudo docker" """
                    docker.withRegistry('https://hyd.ocir.io', 'ocir-docker-login') {
                    dockerImage = docker.build("${ociRegistry}:${BUILD_NUMBER}", "-f ${dockerFile} .")
                    dockerImage.push("${BUILD_NUMBER}")
                    }
                }                   
            }
        }
    }

}
