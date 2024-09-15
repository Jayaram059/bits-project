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
                        sh """ sudo docker build -t ${ociRegistry}:${BUILD_NUMBER} -f Dockerfile .; sudo docker push ${ociRegistry}:${BUILD_NUMBER}"""
                    //dockerImage = docker.build("${ociRegistry}:${BUILD_NUMBER}", "-f ${dockerFile} .")
                    //dockerImage.push("${BUILD_NUMBER}")
                    }
                }                   
            }
        }
        stage('Update OCI Func') {
            steps {

                script {
                    sh """fn update function fn-bits-new fn-bits-trail --image ${ociRegistry}:${BUILD_NUMBER} """
                }                   
            }
        }
    }

}
