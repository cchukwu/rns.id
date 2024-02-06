##rns.id/gcp-vpc/backend.tf

terraform {
  backend "gcs" {
    bucket  = "rns-gcs"
    prefix  = "terraform/state/gcp-vpc"
  }
}
