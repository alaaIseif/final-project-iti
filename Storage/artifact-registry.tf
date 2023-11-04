resource "google_artifact_registry_repository" "main" {
  repository_id = var.repository_id
  format        = var.format
  location       = var.management-region
}
