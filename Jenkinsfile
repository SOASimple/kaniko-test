pipeline{
  agent none
  stages {
    stage('Build & Push') {
      agent {
        kubernetes {
          cloud('kube_dev')
        }
      }
      steps {
        echo 'Building & Pushing'
        sleep(time: 600, unit: 'SECONDS')
      }
    }
  }
}
