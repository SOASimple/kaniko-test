pipeline{
  agent none
  stages {
    stage('Get Github Token') {
      agent {
        kubernetes {
          cloud('kube_dev')
          yaml """
apiVersion: v1
kind: Pod
metadata:
  name: githubapp
spec:
  containers:
  - name: githubapp
    image: roybrumby/git-tool:1.0
    env:
    - name: GITHUB_APP_ID
      value: 309595
    - name: GITHUB_APP_KEY
      value: /githubappkey.pem
    - name: GITHUB_TOKEN_URL
      value: https://api.github.com/app/installations/35633707/access_tokens
    tty: true
    volumeMounts:
    - name: github-conf
      mountPath: /githubappkey.pem
      subPath: githubappkey.pem
  volumes:
  - name: github-conf
    secret:
      secretName: github-app-config
          """
        }
      }
      steps {
        container('githubapp') {
          script {
            env.GITHUB_TOKEN = sh (
              script: '/git-tool.sh jwt $GITHUB_APP_ID $GITHUB_APP_KEY | /git-tool.sh token  $GITHUB_TOKEN_URL',
              returnStdout: true
            ).trim()
          }
        }
      }
    }
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
    - --context=git://x-access-token:${GITHUB_TOKEN}@github.com/rbrumby/kaniko-test.git
    - --dockerfile=/Dockerfile
    - --build-arg=GITHUB_TOKEN=${GITHUB_TOKEN}
    - --destination=roybrumby/kaniko-test:${BUILD_NUMBER}
    tty: true
    volumeMounts:
    - name: roy-dockerhub-creds
      mountPath: /kaniko/.docker
  volumes:
  - name: roy-dockerhub-creds
    secret:
      secretName: roy-dockerhub-creds
          """
        }
      }
      steps {
        echo 'Building & Pushing'
      }
    }
  }
}
