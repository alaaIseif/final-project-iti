
    #!/bin/bash
    echo "Instance provisioned!"

    sudo apt update -y
    sudo apt install apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
    sudo apt install docker-ce
    sudo usermod -aG docker ubuntu
    su - ubuntu
    docker

    "gcloud auth configure-docker ${var.management-region}-docker.pkg.dev",
    "gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin  ${var.management-region}-docker.pkg.dev",
    # install gcp gke auth tools
    "sudo apt-get install kubectl",
    "sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin",
]
