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
            }
        }
        stage('Push to OCIR') {
            steps {
                echo 'Hello World'
                script {

                        docker.build("${ociRegistry}:${BUILD_NUMBER}")
                        
                }                   
            }
        }
        stage('Update OCI Func') {
            steps {

                

                script {
                    docker.withRegistry("https://hyd.ocir.io", "${params.ocirCredential}")
                    docker.push("${ociRegistry}:${BUILD_NUMBER}")
                    //sh """fn update function fn-bits-new fn-bits-trail --image ${ociRegistry}:${BUILD_NUMBER} """
                }                   
            }
        }
    }

}
