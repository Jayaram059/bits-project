pipeline {
    environment {
        ociCrdential = "${params.ocirCredential}"
        ociRegistry = "hyd.ocir.io/axvjenufkdre/bits-genai/genaimage"
        dockerFile = "Dockerfile"
        dockerImage = ''
    }
    agent any


    stages {
        stage('Push to OCIR') {
            steps {
                script {

                        docker.build("${ociRegistry}:${BUILD_NUMBER}").push()
                        
                }                   
            }
        }
    }

}
