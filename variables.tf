variable "project_id" {}
variable "vpc-region" {}

variable "ami" {}
variable "instance_type" {}
variable "management-region" {}
variable "protocol" {}
variable "management-subnet-name" {}
variable "management_subnet_cidr" {}
variable "availability_zones" {
  type        = list(string)
}

####################### Storage ###########################
variable "storage_location" {}

############# VM #############
variable "linux_instance_type" {}
variable "ubuntu_2004_sku" {}
variable "vm_name" {}
variable "metadata_startup_script" {}
variable "repository_id" {}
variable "app_image_name" {}
variable "app_image_version" {}
variable "format" {}
variable "sa-vm-email" {}
variable "sa-vm-id" {}

variable "network-interface" {
    default = ""
}
variable "subnetwork" {
    default = ""
}
variable "nat-ip" {    
    default = ""
}
variable "management-zone" {
    default = ""
}
variable "repo_data" {
    default = ""
}
variable "vm-key" {
    default = ""
}
variable "vm-router-name" {}

################# Workload Variables ###########################
variable "workload-subnet-name" {
    default = ""
}
variable "workload-region" {
    default = ""
}
variable "workload_subnet_cidr" {}
variable "cluster_name" {}
variable "sa-gke-access-email" {}
variable "sa-gke-access-id" {}
variable "deletion_protection" {}
variable "enable_private_nodes" {}
variable "enable_private_endpoint" {}
variable "gke_master_ipv4_cidr_block" {} 
variable "node-pool-name" {}
variable "node-pool-location" {}
variable "node-pool-nodes-count" {}
variable "node_machine_type" {}
variable "node_disk_size_gb" {}