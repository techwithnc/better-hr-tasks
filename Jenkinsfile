def mygvscript
pipeline {
    agent any
    environment {
        APP_VERSION = "5.0"
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
 