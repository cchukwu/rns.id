##rns.id/modules/gcs/main.tf

resource "google_storage_bucket" "terraform_state" {
  name                        = var.bucket_name
  location                    = var.location
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}
