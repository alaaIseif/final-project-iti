# Create managed node pool
resource "google_container_node_pool" "primary_nodes" {
  name       = google_container_cluster.primary.name   
  location   = var.node-pool-location
  cluster    = google_container_cluster.primary.name   
  node_count = 1

    management {
        auto_repair  = true
        auto_upgrade = true
    }

    node_config {
        machine_type    = var.node_machine_type    
        disk_size_gb    = 25
        image_type      = "ubuntu_containerd"
        service_account = var.sa-gke-access-email
        oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
    }
}