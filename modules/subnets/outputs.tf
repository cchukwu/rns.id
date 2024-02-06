##rns.id/modules/subnets/outputs.tf

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = google_compute_subnetwork.public_subnet.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = google_compute_subnetwork.private_subnet.id
}
