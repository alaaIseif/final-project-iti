pipeline {
  agent any

    environment {
        CLOUD_SDK_PROJECT = 'final-devops-iti'
        GOOGLE_APPLICATION_CREDENTIALS = credentials('final-master-key')
        REGION = 'asia-east1'
        GKE_CLUSTER = 'gke-regional-cluster'

    }
    
  stages {
    stage('Checkout') {
      steps {
        git credentialsId: 'githubCred', url: 'https://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@github.com/alaaIseif/final-project-iti.git'
      }
    }

    stage('Configuration'){
        steps{
            sh '''
            sudo apt update -y
            sudo apt install apt-transport-https ca-certificates curl software-properties-common
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
            sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
            sudo apt install docker-ce

            gcloud auth configure-docker us-east1-docker.pkg.dev
            gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin  us-east1-docker.pkg.dev
            '''
        }
    }

    stage('Build Docker Image') {
      steps {
            sh '''
            cd App
            sudo docker build -t us-east1-docker.pkg.dev/final-devops-iti/tf-gcp/hello-world-app:v1 .
            gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin  us-east1-docker.pkg.dev
            sudo docker push us-east1-docker.pkg.dev/final-devops-iti/tf-gcp/hello-world-app:v1 
            '''
      }
    }

    stage('Deploy to GKE') {
      steps {
        script {
          sh '''
          sudo apt-get install -y kubectl
          sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
          sudo apt-get update && sudo apt-get --only-upgrade install google-cloud-sdk-cbt google-cloud-sdk-app-engine-go google-cloud-sdk-config-connector google-cloud-sdk google-cloud-sdk-harbourbridge google-cloud-sdk-enterprise-certificate-proxy google-cloud-sdk-minikube google-cloud-sdk-app-engine-python-extras google-cloud-sdk-cloud-run-proxy google-cloud-sdk-datastore-emulator google-cloud-sdk-package-go-module google-cloud-sdk-skaffold google-cloud-sdk-firestore-emulator google-cloud-sdk-spanner-migration-tool google-cloud-sdk-log-streaming google-cloud-sdk-app-engine-grpc google-cloud-sdk-pubsub-emulator google-cloud-sdk-spanner-emulator google-cloud-sdk-app-engine-python google-cloud-sdk-kubectl-oidc kubectl google-cloud-sdk-terraform-tools google-cloud-sdk-nomos google-cloud-sdk-app-engine-java google-cloud-sdk-bigtable-emulator google-cloud-sdk-local-extract google-cloud-sdk-cloud-build-local google-cloud-sdk-kpt google-cloud-sdk-anthos-auth google-cloud-sdk-gke-gcloud-auth-plugin
          sudo gcloud components list
          gcloud container clusters get-credentials ${GKE_CLUSTER} --region ${REGION} --project ${CLOUD_SDK_PROJECT}
          cd App
          kubectl config set-context --current
          kubectl apply -f deployment.yaml
          '''
        }
      }
    }
  }
}
