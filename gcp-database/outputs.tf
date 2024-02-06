##rns.id/gcp-database/outputs.tf

output "db_instance_id" {
  value       = module.database.instance_id
  description = "The ID of the created database instance."
}
