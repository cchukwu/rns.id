##rns.id/cloud-run/variables.tf

variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "devops-rns"
}

variable "region" {
  description = "The region for the resources"
  type        = string
  default     = "us-central1"
}