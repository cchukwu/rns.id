##rns.id/remote-backend/variables.tf

variable "project_id" {
  description = "The GCP project ID where the bucket will be created."
  type        = string
  default     = "devops-rns"
}
