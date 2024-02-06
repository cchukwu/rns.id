##rns.id/modules/firewall/variables.tf

variable "network" {
  description = "The VPC network ID where the firewall will be applied"
  type        = string
}

variable "allow_internal_cidrs" {
  description = "CIDR blocks that are allowed internally"
  type        = list(string)
  default     = ["10.0.0.0/8"]
}

variable "allow_external_ports" {
  description = "Ports that are allowed externally"
  type        = list(string)
  default     = ["22", "80", "443"]
}
