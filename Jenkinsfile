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

                       dockerImage=docker.build("${ociRegistry}:${BUILD_NUMBER}").push()
                        dockerImage.push("latest")
                        
                }                   
            }
        }
    }


post {
    success {
        echo "Image success lets update OCI Infra"
        build job: 'OCI_Infra_Updator', 
                      parameters: [
                          string(name: 'terraformAction', value: "plan")
                      ]
    }
}
}
