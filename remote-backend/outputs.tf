##rns.id/remote-backend/outputs.tf

output "gcs_bucket_name" {
  value       = module.gcs_bucket.bucket_name
  description = "The name of the created GCS bucket for Terraform state storage."
}
