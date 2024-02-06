##rns.id/modules/gcs/variables.tf

variable "bucket_name" {
  description = "The name of the GCS bucket to store Terraform state files."
  type        = string
}

variable "location" {
  description = "The location for the GCS bucket."
  type        = string
  default     = "US"
}

variable "force_destroy" {
  description = "Enables or disables the force destroy option to allow deleting the bucket with all its contents."
  type        = bool
  default     = false
}
