data "google_project" "current" {}

data "google_compute_instance" "vm_instance" {
  name = google_compute_instance.vm_instance.name
  zone         = var.management-zone
}

resource "google_compute_instance" "vm_instance" {
  name         = var.vm_name
  machine_type = var.linux_instance_type
  tags         = ["allow-ssh"] // this receives the firewall rule
  zone         = var.management-zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

   network_interface {
    network = var.network-interface
    subnetwork = var.subnetwork
    }
    
    metadata_startup_script = file(var.metadata_startup_script) 
}