pipeline {
    agent any

    stages {
        stage('Terraform version') {
            steps {
                sh 'terraform --version'
            }
        }

        stage('Check files') {
            steps {
                sh 'ls -l'
            }
        }

        stage('Terraform init') {
            steps {
                dir('eks_configuration') {
                    sh 'terraform init -upgrade'
                }
            }
        }

        stage('Terraform plan') {
            steps {
                dir('eks_configuration') {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform apply') {
            steps {
                dir('eks_configuration') {
                    sh 'terraform apply --auto-approve'
                    sh 'sleep 600'
                }
            }
        }
    }
}
