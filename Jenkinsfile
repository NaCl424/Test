pipeline {
  agent none
  stages {
    stage('Start') {
      parallel {
        stage('Start') {
          steps {
            echo 'Start Build'
            sh 'echo \'start build...\''
          }
        }

        stage('Start2') {
          steps {
            echo 'Start2'
          }
        }

      }
    }

  }
}