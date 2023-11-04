output vpc_name {
  value = google_compute_network.main.name
}

output subnetwork {
  value = google_compute_subnetwork.private-management.name
}

output "nat-ip" {
  value = google_compute_address.static_ip.address
}

output workload-subnetwork {
  value = google_compute_subnetwork.private-workload.name
}
