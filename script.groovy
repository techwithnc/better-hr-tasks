def buildApp() {
    sh "mvn clean package"
}
def buildImage(){
    sh "docker build -t techwithnc/simple-java-app:$IMAGE_NAME ."
    sh "docker image ls"
}
def pushImage(){
    withCredentials([usernamePassword(credentialsId: 'dockerhub-token', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]){
                        sh "echo $PASSWORD | docker login -u $USERNAME --password-stdin"
                        sh "docker push techwithnc/simple-java-app:$IMAGE_NAME"
                    }
}
return this