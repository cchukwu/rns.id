##rns.id/remote-backend/main.tf

module "gcs_bucket" {
  source       = "../modules/gcs"
  bucket_name  = "rns-state-${var.project_id}"
  location     = "US"
  force_destroy = false
}
