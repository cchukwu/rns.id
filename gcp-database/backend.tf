##rns.id/gcp-database/backend.tf

terraform {
  backend "gcs" {
    bucket  = "rns-state-devops-rns"
    prefix  = "terraform/state/gcp-database"
  }
}
