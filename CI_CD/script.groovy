def buildImage(){
    sh "docker build -t techwithnc/betterhrapp:$APP_VERSION ."
}
def pushImage(){
    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]){
                        sh "echo $PASSWORD | docker login -u $USERNAME --password-stdin"
                        sh "docker push techwithnc/betterhrapp:$APP_VERSION"
                    }
}
def deployImage(){
    def shellcmd = "bash ./scripts.sh ${APP_VERSION}"
    def svr = "ubuntu@3.96.169.134"
    sshagent(['awssvrssh']){
        sh "scp scripts.sh ${svr}:/home/ubuntu "
        sh "ssh -o StrictHostKeyChecking=no ${svr} ${shellcmd}"
    }
}
return this