##rns.id/cloud-run/backend.tf

terraform {
  backend "gcs" {
    bucket  = "rns-state-devops-rns"
    prefix  = "terraform/state/cloud-run"
  }
}
