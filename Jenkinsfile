def mygvscript
pipeline {
    agent any
    environment {
        IMAGE_NAME = "1"
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
    //     stage("Build_App"){
    //         steps{
    //             script{
    //                 mygvscript.buildApp()
    //                 APP_VERSION = readMavenPom().getVersion()
    //                 IMAGE_NAME = "${APP_VERSION}-${env.BUILD_ID}"
    //             }
    //         }
    //     }
    //     stage("Build_IMAGE"){
    //         steps {
    //             script {
    //                 mygvscript.buildImage()
    //             }
    //         }
    //     }
    //     stage("Push_IMAGE") {
    //         steps {
    //             script {
    //                 mygvscript.pushImage()
    //             }
    //         }
    //     }
    }
}
 