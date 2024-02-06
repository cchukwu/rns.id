##rns.id/cloud-run/outputs.tf

output "service_url" {
  value       = google_cloud_run_service.cloud_run_service.status[0].url
  description = "The URL of the deployed Cloud Run service"
}

# Output the IP of the Load Balancer
output "load_balancer_ip" {
  value       = google_compute_global_forwarding_rule.http_forwarding_rule.ip_address
  description = "The IP address of the HTTP Load Balancer"
}

