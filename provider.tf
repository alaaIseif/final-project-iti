# Configure the GCP Provider
provider "google" {
    project     = "terraform-project-iti"
    region      = "asia-south2"
    credentials = file("master-terraform-project-iti.json")

}