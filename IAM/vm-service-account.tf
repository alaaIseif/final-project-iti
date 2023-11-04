# resource "google_service_account" "vm" {
#   account_id   = var.sa-vm-id
#   display_name = "A service account that only vms can ssh to"
#   project = "testingsevices"
# }

# resource "google_service_account_key" "vm-key" {
#   service_account_id = google_service_account.vm.name
# }

resource "google_service_account" "vm" {
    account_id = var.sa-vm-id
}

resource "google_project_iam_member" "vm-iam1" {
    project = var.project_id
    role = "roles/artifactregistry.admin" //"projects/${var.project_id}/roles/editor"//${google_project_iam_custom_role.vm.role_id}
    member = "serviceAccount:${var.sa-vm-email}"
}
resource "google_project_iam_member" "vm-iam2" {
    project = var.project_id
    role = "roles/container.admin" //"projects/${var.project_id}/roles/editor"//${google_project_iam_custom_role.vm.role_id}
    member = "serviceAccount:${var.sa-vm-email}"
}
