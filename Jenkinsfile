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

        stage('Terraform apply') {
            steps {
                sh 'terraform apply --auto-approve'
                sh 'sleep 600'
            }
        }
    }
}
