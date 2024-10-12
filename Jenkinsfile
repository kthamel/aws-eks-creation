pipeline {
    agent any

    stages {
        stage('Terraform version') {
            steps {
                sh 'terraform --version'
            }
        }

        stage('Terraform init') {
            steps {
                sh 'terraform init -upgrade'
            }
        }

        stage('Terraform plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Request Approval') {
            steps {
                script {
                   timeout(time: 1, unit: 'HOURS') {
                        approvalStatus = input message: 'Are you sure? ', ok: 'Submit', parameters: [choice(choices: ['Approved', 'Rejected'], name: 'ApprovalStatus')], submitter: 'user1,user2', submitterParameter: 'approverID'
                   }
                }
                echo "Approval status: ${approvalStatus}"
            }
        }

        stage('Terraform Apply') {
            when {
                expression { approvalStatus["ApprovalStatus"] == 'Approved' }
            }
            steps {
                sh 'terraform apply --auto-approve'
            }
        }

        stage ('Invoke Downstream Pipeline') {
            steps {
                build job: 'pipeline-eks-application', wait: true
            }
        }
    }
}
