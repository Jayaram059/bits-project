pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
                script {
                    bat "cmd /c git branch; docker images"
                }

                    
            }
        }
    }
}
