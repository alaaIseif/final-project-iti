resource "google_compute_address" "static_ip" {
  name = "ubuntu-vm"
}

resource "google_compute_firewall" "iap_to_ssh" {
  name    = "ingress-allow-iap-to-ssh"
  network = google_compute_network.main.name

  direction = "INGRESS"
  priority  = 1000

  # Cloud IAP's TCP forwarding netblock
  source_ranges = ["35.235.240.0/20"]
  target_tags = ["allow-ssh"]

  allow {
    protocol = "tcp"
    ports    = [22]
  }
}

data "google_client_openid_userinfo" "me" {}