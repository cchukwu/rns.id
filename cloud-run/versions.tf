##rns.id/cloud-run/versions.tf

terraform {
  required_version = "= 1.2.9"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "= 5.15.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
