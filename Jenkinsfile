pipeline{
  agent none
  stages {
    stage('Build & Push') {
      agent {
        kubernetes {
          cloud('kube_dev')
          yaml """
apiVersion: v1
kind: Pod
metadata:
  name: kaniko-test
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:v1.9.1
    command:
    - /kaniko/executor
    args:
    # - --context=git://github.com/rbrumby/kaniko-test.git
    - --context=dir:///jenkins/workspace/SOA-Simple_kaniko-test_main
    - --dockerfile=Dockerfile
    - --destination=roybrumby/kaniko-test:1.4
    tty: true
    volumeMounts:
    - name: workspace-volume
      mountPath: /jenkins
    - name: github-app-key
      mountPath: /githubappkey.pem
      subPath: githubappkey.pem
    - name: roy-dockerhub-creds
      mountPath: /kaniko/.docker
  volumes:
  - name: github-app-key
    secret:
      secretName: github-app-key
  - name: roy-dockerhub-creds
    secret:
      secretName: roy-dockerhub-creds
          """
        }
      }
      steps {
        echo 'Building & Pushing'
        // sleep time: 600, unit: 'SECONDS'
      }
    }
  }
}
