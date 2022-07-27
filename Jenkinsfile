pipeline {
    agent any

    stages {
        stage('Test') {
                    steps {
                        sh 'echo "Start Test"'
                        sh 'PATH=$PATH:/var/jenkins_home/go/bin && CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go mod tidy'
                        sh 'PATH=$PATH:/var/jenkins_home/go/bin && CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go test ./...'
                    }
                }
        stage('Compile') {
                    steps {
                           sh 'echo "Start Build"'
                           sh 'PATH=$PATH:/var/jenkins_home/go/bin && CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -o biz main.go'
                    }
        }
        stage('Build') {
		            agent {
                         docker { image 'alpinelinux/docker-cli' }
                    }
            steps {
                sh 'echo "Start Build"'
				sh 'docker build -t sre/ipregion:arm64 .'

            }
        }
        stage('Deploy') {
                    when {
                      expression {
                        currentBuild.result == null || currentBuild.result == 'SUCCESS'
                        //访问该currentBuild.result变量允许Pipeline确定是否有任何测试失败。在这种情况下，值将是 UNSTABLE。
                      }
                    }
                    steps {
                        sh 'PATH=$PATH:/var/jenkins_home/go/bin && kubectl rollout restart deployment -n sre gocicd'
                    }
                }
    }
}