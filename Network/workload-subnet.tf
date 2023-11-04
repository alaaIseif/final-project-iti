resource "google_compute_subnetwork" "private-workload" {
  name                     = var.workload-subnet-name 
  ip_cidr_range            = var.workload_subnet_cidr 
  region                   = var.workload-region 
  network                  = google_compute_network.main.id
  private_ip_google_access = true
}
