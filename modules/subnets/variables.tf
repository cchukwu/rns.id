##rns.id/modules/subnets/variables.tf

variable "vpc_id" {
  description = "The ID of the VPC for the subnets"
  type        = string
}

variable "public_subnet_name" {
  description = "The name of the public subnet"
  type        = string
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_name" {
  description = "The name of the private subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = string
}

variable "region" {
  description = "The region where the subnets will be created"
  type        = string
}
