############ Managment Subnet ###############

variable "management-region" {}
variable "management-zone" {}
variable "linux_instance_type" {}
variable "ubuntu_2004_sku" {}
variable "sa-vm-email" {}
variable "network-interface" {}
variable "subnetwork" {}
variable "nat-ip" {}
variable "project_id" {}
variable "repository_id" {}
variable "app_image_name" {}
variable "app_image_version" {}
variable "vm_name" {}

############ Workload Subnet ###############
variable "cluster_name" {}
variable "workload-region" {}
variable "workload-subnet-name" {}
variable "workload_subnet_cidr" {}
variable "deletion_protection" {}
variable "enable_private_nodes" {}
variable "enable_private_endpoint" {}
variable "gke_master_ipv4_cidr_block" {}
variable "sa-gke-access-email" {}
variable "sa-gke-access-id" {}
variable "node-pool-name" {}
variable "node-pool-location" {}
variable "node-pool-nodes-count" {}
variable "metadata_startup_script" {}
variable "node_machine_type" {}
variable "node_disk_size_gb" {}
variable "availability_zones" {
  type        = list(string)
}
