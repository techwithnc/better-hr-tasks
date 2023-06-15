def buildImage(){
    sh "sudo docker build -t techwithnc/betterhrapp:$IMAGE_NAME ."
    sh "sudo docker image ls"
}
def pushImage(){
    withCredentials([usernamePassword(credentialsId: 'dockerhub-token', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]){
                        sh "echo $PASSWORD | docker login -u $USERNAME --password-stdin"
                        sh "docker push techwithnc/simple-java-app:$IMAGE_NAME"
                    }
}
return this