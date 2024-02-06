##rns.id/cloud-run/main.tf

data "terraform_remote_state" "vpc" {
  backend = "gcs"
  config = {
    bucket  = "rns-state-devops-rns"
    prefix  = "terraform/state/gcp-vpc"
  }
}

# Serverless VPC Access connector
resource "google_vpc_access_connector" "serverless_connector" {
  name          = "serverless-connector"
  region        = var.region
  network       = data.terraform_remote_state.vpc.outputs.vpc_id
  ip_cidr_range = "10.8.0.0/28"
}

# Cloud Run service
resource "google_cloud_run_service" "cloud_run_service" {
  name     = "rns-service"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true

  depends_on = [
    google_vpc_access_connector.serverless_connector
  ]
}
