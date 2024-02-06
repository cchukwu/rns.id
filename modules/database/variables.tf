##rns.id/modules/database/variables.tf

variable "instance_name" {
  description = "Name of the SQL database instance."
  type        = string
}

variable "database_version" {
  description = "The version of the database."
  type        = string
}

variable "region" {
  description = "The region of the database."
  type        = string
}

variable "tier" {
  description = "The tier of the database instance."
  type        = string
}

variable "subnets" {
  description = "A list of subnet IDs for the database"
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC where the database should be deployed."
  type        = string
}

