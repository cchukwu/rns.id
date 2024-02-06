##rns.id/gcp-vpc/backend.tf

terraform {
  backend "gcs" {
    bucket  = "rns-state-devops-rns"
    prefix  = "terraform/state/gcp-vpc"
  }
}
