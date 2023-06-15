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
return this