resource "google_container_cluster" "primary" {
  name                     = var.cluster_name
  location                 = var.workload-region
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.network-interface
  subnetwork               = var.workload-subnet-name
  networking_mode          = "VPC_NATIVE"
  deletion_protection      = false

  # Optional, if you want multi-zonal cluster
  node_locations =  var.availability_zones
  node_config {
    disk_size_gb = 25
  }
  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }
  workload_identity_config { //allows workloads to impersonate Identity and Access Management (IAM) service accounts to access Google Cloud services.
    workload_pool = "${var.project_id}.svc.id.goog"
  }
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = var.workload_subnet_cidr
    }
  }

  private_cluster_config {
    enable_private_nodes    = var.enable_private_nodes  //the cluster's nodes will have private IP addresses instead of public IP addresses
    enable_private_endpoint = var.enable_private_endpoint  //the cluster's master will have a public IP address.
    master_ipv4_cidr_block  = "172.168.0.0/28"
  }
}

