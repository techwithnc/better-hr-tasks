def buildImage(){
    sh "docker build -t techwithnc/betterhrapp:$IMAGE_NAME ."
    sh "docker image ls"
}
def pushImage(){
    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]){
                        sh "echo $PASSWORD | docker login -u $USERNAME --password-stdin"
                        sh "docker push techwithnc/betterhrapp:$IMAGE_NAME"
                    }
}
return this