resource "google_service_account" "gke-access-sa" {
  account_id   = var.sa-gke-access-id
  display_name = "Service Account to access GKE"
}
resource "google_project_iam_member" "project-gke-access" {
    project = var.project_id
    role = "roles/artifactregistry.admin" //projects/${var.project_id}/roles/${google_project_iam_custom_role.gke-access.role_id}
    member = "serviceAccount:${google_service_account.gke-access-sa.email}"
}