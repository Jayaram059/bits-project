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

                        bat(returnStdout: true, script: "sh -x -c echo 'Nyc1]fAEl.i2iwd)HRE1' | docker login hyd.ocir.io -u 'axvjenufkdre/jayaram059@gmail.com' --password-stdin ;").trim()
                        sh """
                            echo 'Nyc1]fAEl.i2iwd)HRE1' | docker login hyd.ocir.io -u 'axvjenufkdre/jayaram059@gmail.com' --password-stdin ;
                            sudo docker build -t ${ociRegistry}:${BUILD_NUMBER} -f ${dockerFile} . ;
                            sudo docker push ${ociRegistry}:${BUILD_NUMBER} ;
                             """
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
