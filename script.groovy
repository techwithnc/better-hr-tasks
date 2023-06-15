def buildImage(){
    sh "docker build -t techwithnc/betterhrapp:$APP_VERSION ."
    sh "docker image ls"
}
def pushImage(){
    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]){
                        sh "echo $PASSWORD | docker login -u $USERNAME --password-stdin"
                        sh "docker push techwithnc/betterhrapp:$APP_VERSION"
                    }
}
def deployImage(){
withCredentials([sshUserPrivateKey(credentialsId: 'svr01-ssh', keyFileVariable: 'SSH_KEY_FILE', passphraseVariable: '', usernameVariable: 'ubuntu')]) {
                    sshagent(['SSH_KEY_FILE']) {
                        sshCommand remote: "ssh -o StrictHostKeyChecking=no $SSH_USERNAME@99.79.67.178",
                            command: '''
                                sudo docker image pull techwithnc/betterhrapp:5.0
                            '''                  
                    }
                }
}
return this