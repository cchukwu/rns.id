##rns.id/modules/gcs/outputs.tf

output "bucket_name" {
  value       = google_storage_bucket.terraform_state.name
  description = "The name of the GCS bucket."
}
