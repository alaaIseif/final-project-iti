# Configure the GCP Provider
provider "google" {
    project     = "terraform-project-iti"
    region      = "asia-south2"
    credentials = "master-terraform-project-iti.json"
}