##rns.id/gcp-database/variables.tf

#variable "vpc_id" {
#  description = "The ID of the VPC to which the database should connect."
#  type        = string
#}

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
