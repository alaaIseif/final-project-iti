pipeline {
  agent any

    environment {
        CLOUD_SDK_PROJECT='final-devops-iti'
        GCLOUD_EMAIL='master@final-devops-iti.iam.gserviceaccount.com'
        GCLOUD_CREDS=credentials('671f7c9b-46a1-4bba-8568-b94a16b48b38')
    }
    
  stages {
    stage('Checkout') {
      steps {
        git credentialsId: 'githubCred', url: 'https://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@github.com/alaaIseif/final-project-iti.git'
      }
    }

    stage('Docker Configuration'){
        steps{
            sh '''
            sudo apt update -y
            sudo apt install apt-transport-https ca-certificates curl software-properties-common
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
            sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
            sudo apt install docker-ce
            sudo usermod -aG docker ubuntu
            su - ubuntu
            docker

            gcloud auth configure-docker us-east1-docker.pkg.dev
            gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin  us-east1-docker.pkg.dev
            '''
        }
    }


    stage('Build Docker Image') {
      steps {
       sh 'docker build -t hello-world-app:v1 .'
       sh 'docker push hello-world-app:v1' 
      }
    }


    stage('Deploy to GKE') {
      steps {
        script {
          gcloudProject = "${CLOUD_SDK_PROJECT}"
          gkeCluster = 'gke-regional-cluster'
        //   gkeZone = 'gke-regional-cluster'
          gcloudCredentials = credentials("${GCLOUD_CREDS}")

          sh "gcloud config set project ${CLOUD_SDK_PROJECT}"
          sh "gcloud container clusters get-credentials ${gkeCluster} --project ${gcloudProject}"
          sh "kubectl config set-context --current"
          sh "kubectl apply -f deployment.yaml"
        }
      }
    }

    stage('Cleaning up') {
        steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
        }
    }
  }
}