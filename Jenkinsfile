def mygvscript
pipeline {
    agent any
    environment {
        IMAGE_NAME = "4.0"
        APP_VERSION = ""
    }
    stages{
        stage("Prepare"){
            steps{
                script{
                    mygvscript = load "script.groovy"
                }
            }
        }
        stage("Build_DOCKER_IMAGE"){
            steps {
                script {
                    mygvscript.buildImage()
                }
            }
        }
        stage("Push_DOCKER_IMAGE") {
            steps {
                script {
                    mygvscript.pushImage()
                }
            }
        }
    }
}
 