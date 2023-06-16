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
    withCredentials([sshUserPrivateKey(credentialsId: 'svrssh', keyFileVariable: 'SSH_KEY_FILE', passphraseVariable: '', usernameVariable: 'SSH_USERNAME')]) {
                    sshagent(['SSH_KEY_FILE']) {
                        sshCommand remote: "ssh -o StrictHostKeyChecking=no $SSH_USERNAME@35.182.131.225",
                            command: '''
                                sudo docker image pull techwithnc/betterhrapp:5.0
                            '''                  
                    }
                }
}
///
//
// def deployImage(){
//     // def dockerRun = 'sudo docker image pull techwithnc/betterhrapp:5.0'
//     sshagent(['svr01-ssh']){
//        sh 'ssh -o StrictHostKeyChecking=no ubuntu@3.96.169.134 echo'
//     }
// }
return this