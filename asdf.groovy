    stages {
        stage('Deploy') {
            steps {
                // Prepare SSH credentials for remote server
                withCredentials([sshUserPrivateKey(credentialsId: 'svr01-ssh', keyFileVariable: 'SSH_KEY_FILE', passphraseVariable: '', usernameVariable: 'SSH_USERNAME')]) {
                    // Run commands on remote server
                    sshagent(['SSH_KEY_FILE']) {
                        sshCommand remote: "ssh -o StrictHostKeyChecking=no $SSH_USERNAME@35.182.131.225",
                            command: '''
                                # Command 1
                                echo "Running Command 1"

                                # Command 2
                                echo "Running Command 2"
                            '''
                    }
                }
            }
        }
    }
}