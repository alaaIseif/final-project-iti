pipeline {
    agent any
    tools {
    terraform 'terraform_1.5.7'
    }
    environment {
        CLOUD_SDK_PROJECT = 'final-devops-iti'
        GOOGLE_APPLICATION_CREDENTIALS = credentials('final-master-key')
    }
    parameters {
        booleanParam(name: 'autoApprove', defaultValue: true, description: 'Automatically run apply after generating plan?')
        choice(name: 'action', choices: ['apply', 'destroy'], description: 'Select the action to perform')
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'githubCred', url: 'https://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@github.com/alaaIseif/final-project-iti.git'
            }
        }
        stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('GCP authentication') {
            steps{
                // Set up Google Cloud SDK

                sh '''gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}
                gcloud config set project ${CLOUD_SDK_PROJECT}'''
                
                }
            // }
        }
        stage('Plan') {
            steps {
                sh '''terraform plan -out=tfplan
                terraform show -no-color tfplan > tfplan.txt'''
            }
        }
        stage('Apply / Destroy') {
            steps {
                script {
                    if (params.action == 'apply') {
                        if (!params.autoApprove) {
                            def plan = readFile 'tfplan.txt'
                            input message: "Do you want to apply the plan?",
                            parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                        }

                        sh 'terraform ${action} -input=false tfplan'
                    } else if (params.action == 'destroy') {
                        sh 'terraform ${action} --auto-approve'
                    } else {
                        error "Invalid action selected. Please choose either 'apply' or 'destroy'."
                    }
                }
            }
        }
        stage('Trigger Deployment Pipeline') {
        steps {
            build job: 'deploying-web-app'
            }
        }
    }
    
}