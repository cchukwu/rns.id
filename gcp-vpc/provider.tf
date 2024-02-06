##rns.id/gcp-vpc/provider.tf

provider "google" {
  project = var.project_id
  region  = "us-central1"
}
