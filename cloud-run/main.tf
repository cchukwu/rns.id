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

# Cloud Run service with unauthenticated access
resource "google_cloud_run_service" "cloud_run_service" {
  name     = "rns-service"
  location = var.region

  template {
    metadata {
      annotations = {
        "run.googleapis.com/ingress" = "all"
        "run.googleapis.com/allow-unauthenticated" = "true"
      }
    }
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

# Serverless Network Endpoint Group (NEG) for Cloud Run
resource "google_compute_region_network_endpoint_group" "cloud_run_neg" {
  name                  = "cloud-run-neg"
  region                = var.region
  network_endpoint_type = "SERVERLESS"
  cloud_run {
    service = google_cloud_run_service.cloud_run_service.name
  }
}

# URL Map to route incoming requests
resource "google_compute_url_map" "url_map" {
  name            = "cloud-run-url-map"
  default_service = google_compute_backend_service.cloud_run_backend.id
}

# HTTP Proxy to route requests to the URL Map
resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "http-proxy"
  url_map = google_compute_url_map.url_map.id
}

# Global Forwarding Rule to direct traffic to the HTTP Proxy
resource "google_compute_global_forwarding_rule" "http_forwarding_rule" {
  name       = "http-content-forwarding-rule"
  target     = google_compute_target_http_proxy.http_proxy.id
  port_range = "80"
}

# Backend service for Cloud Run
resource "google_compute_backend_service" "cloud_run_backend" {
  name        = "cloud-run-backend-service"
  protocol    = "HTTP"

  backend {
    group = google_compute_region_network_endpoint_group.cloud_run_neg.id
  }
}

# Grant public access to the Cloud Run service
resource "google_cloud_run_service_iam_binding" "public_invoker" {
  location = google_cloud_run_service.cloud_run_service.location
  service  = google_cloud_run_service.cloud_run_service.name

  role = "roles/run.invoker"

  members = [
    "allUsers",
  ]

  depends_on = [
    google_cloud_run_service.cloud_run_service,
  ]
}


