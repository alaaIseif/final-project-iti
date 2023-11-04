project_id = "final-devops-iti"
vpc-region = "us-east1"

##################  Management Subnet ####################
management-subnet-name = "management-subnet" 
ami="ami-06e46074ae430fba6"
instance_type="t2.micro"
management_subnet_cidr = "10.2.0.0/16"
management-region = "us-east1"
management-zone = "us-east1-b"
availability_zones=["asia-south2-a", "asia-south2-b", "asia-south2-c"]
protocol="tcp"

################### VM ###################
sa-vm-email = "vm-dev@final-devops-iti.iam.gserviceaccount.com"
sa-vm-id = "vm-dev"
metadata_startup_script = "Compute/script.sh"
vm_name = "management-vm"
linux_instance_type = "f1-micro"
ubuntu_2004_sku = "ubuntu-os-cloud/ubuntu-2004-lts"
vm-router-name = "vm-router"

################### Artifact Repo ###################
repository_id = "tf-gcp"
app_image_name="nodejs-app-image"
app_image_version ="v1"
format        = "DOCKER"
storage_location = "US-EAST1"


################## Cluster Variables ##################
workload-subnet-name = "workload-subnet"
workload-region = "asia-south2"
workload_subnet_cidr = "172.16.0.0/12"
cluster_name = "gke-regional-cluster"
sa-gke-access-email = "gke-access@final-devops-iti.iam.gserviceaccount.com"
sa-gke-access-id = "gke-access"
deletion_protection = "false"
enable_private_nodes = "true"
enable_private_endpoint = "false"
gke_master_ipv4_cidr_block = "172.16.0.0/28" //10.13.0.0/28
node-pool-name = "regional-workload-node-pool"
node-pool-location = "asia-south2"
node-pool-nodes-count = 1
node_machine_type = "e2-micro"
node_disk_size_gb = 10