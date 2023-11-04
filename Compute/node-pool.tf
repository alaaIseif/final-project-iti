# Create managed node pool
resource "google_container_node_pool" "primary_nodes" {
  name       = google_container_cluster.primary.name
  cluster    = google_container_cluster.primary.name
  location   = var.node-pool-location
  node_count = 1

    management {
        auto_repair  = true
        auto_upgrade = true
    }

    node_config {
        machine_type    = var.node_machine_type
        service_account = var.sa-gke-access-email
        oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
    }
}