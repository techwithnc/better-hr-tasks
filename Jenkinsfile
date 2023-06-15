// Author: "Tech With NC"
// 
//  Date Created: 1/Feb/2023
//  Last Modified: 1/Jun/2023
//  
//  Description.
//  Jenkinsfile.

def mygvscript
pipeline {
    agent any
    environment {
        IMAGE_NAME = ""
        APP_VERSION = ""
    }
    tools{
        maven '01Maven'
    }
    stages{
        stage("Prepare"){
            steps{
                script{
                    mygvscript = load "script.groovy"
                }
            }
        }
        stage("Build_App"){
            steps{
                script{
                    mygvscript.buildApp()
                    APP_VERSION = readMavenPom().getVersion()
                    IMAGE_NAME = "${APP_VERSION}-${env.BUILD_ID}"
                }
            }
        }
        stage("Build_IMAGE"){
            steps {
                script {
                    mygvscript.buildImage()
                }
            }
        }
        stage("Push_IMAGE") {
            steps {
                script {
                    mygvscript.pushImage()
                }
            }
        }
    }
}
 