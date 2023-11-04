# Configure the GCP Provider
provider "google" {
    project     = "final-devops-iti"
    region      = "asia-south2"
    credentials = "master-final-devops-iti-key.json"
}