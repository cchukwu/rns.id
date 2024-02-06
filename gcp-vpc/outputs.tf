##rns.id/gcp-vpc/outputs.tf

output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = module.subnets.public_subnet_id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = module.subnets.private_subnet_id
}

output "firewall_internal_id" {
  description = "The ID of the internal firewall rule"
  value       = module.firewall.firewall_internal_id
}

output "firewall_external_id" {
  description = "The ID of the external firewall rule"
  value       = module.firewall.firewall_external_id
}
