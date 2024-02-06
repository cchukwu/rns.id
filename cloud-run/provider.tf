##rns.id/cloud-run/provider.tf

provider "google" {
  project = var.project_id
  region  = var.region
}
