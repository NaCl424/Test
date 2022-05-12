pipeline {
  agent any
  stages {
    stage('Start') {
      parallel {
        stage('Start') {
          steps {
            echo 'Start Build'
            sh '''#!/bin/sh
echo \'start build...\''''
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