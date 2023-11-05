resource "google_compute_subnetwork" "private-management" {
  name          = var.management-subnet-name
  ip_cidr_range = var.management_subnet_cidr
  network       = google_compute_network.main.id
  region        = var.management-region //"asia-south2"
  private_ip_google_access = true
}
