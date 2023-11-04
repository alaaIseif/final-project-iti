resource "google_compute_network" "main" {
    name = "main-vpc-${var.vpc-region}"
    auto_create_subnetworks = false
}