##rns.id/modules/firewall/outputs.tf

output "firewall_internal_id" {
  description = "The ID of the internal firewall rule"
  value       = google_compute_firewall.allow_internal.id
}

output "firewall_external_id" {
  description = "The ID of the external firewall rule"
  value       = google_compute_firewall.allow_external.id
}
