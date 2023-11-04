output "sa-vm-email" {
  value = google_service_account.vm.email
}

output "vm-service-account-id" {
  value = google_service_account.vm.account_id
}

output "gke-access-service-account-id" {
  value = google_service_account.gke-access-sa.account_id
}

