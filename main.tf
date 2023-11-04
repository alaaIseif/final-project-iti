module "Network" {
  source = "./Network"
  management-subnet-name = var.management-subnet-name
  management_subnet_cidr = var.management_subnet_cidr
  instance_type = var.instance_type
  ami = var.ami
  protocol = var.protocol
  vm-service-account-id = module.IAM.vm-service-account-id
  project_id = var.project_id
  management-region = var.management-region
  vpc-region = var.vpc-region
  workload-region = var.workload-region
  workload_subnet_cidr = var.workload_subnet_cidr
  workload-subnet-name = var.workload-subnet-name
  vm-router-name = var.vm-router-name
}

module "IAM" {
  source = "./IAM"
  project_id = var.project_id
  sa-vm-email = var.sa-vm-email
  sa-vm-id = var.sa-vm-id
  sa-gke-access-email = var.sa-gke-access-email
  sa-gke-access-id = var.sa-gke-access-id
  node-pool-name = var.node-pool-name
}

module "Compute" {
    source = "./Compute"
    management-region = var.management-region
    vm_name = var.vm_name
    ubuntu_2004_sku = var.ubuntu_2004_sku
    linux_instance_type = var.linux_instance_type
    app_image_version = var.app_image_version
    app_image_name = var.app_image_name
    metadata_startup_script = var.metadata_startup_script
    sa-vm-email =  module.IAM.sa-vm-email
    network-interface = module.Network.vpc_name
    subnetwork = module.Network.subnetwork
    nat-ip = module.Network.nat-ip
    management-zone = var.management-zone
    project_id = var.project_id
    repository_id = var.repository_id
    workload-region = var.workload-region
    workload-subnet-name = module.Network.workload-subnetwork
    cluster_name = var.cluster_name
    sa-gke-access-email = module.IAM.sa-vm-email
    sa-gke-access-id = module.IAM.gke-access-service-account-id
    deletion_protection = var.deletion_protection
    enable_private_nodes = var.enable_private_nodes
    enable_private_endpoint = var.enable_private_endpoint
    gke_master_ipv4_cidr_block = var.gke_master_ipv4_cidr_block
    node-pool-name = var.node-pool-name
    node-pool-location = var.node-pool-location
    node-pool-nodes-count = var.node-pool-nodes-count
    node_machine_type = var.node_machine_type
    node_disk_size_gb = var.node_disk_size_gb
    availability_zones = var.availability_zones
    workload_subnet_cidr = var.workload_subnet_cidr
    }

module "Storage" {
  source = "./Storage"
  storage_location = var.storage_location
  repository_id = var.repository_id
  format        = var.format
  project_id = var.project_id
  management-region = var.management-region
}