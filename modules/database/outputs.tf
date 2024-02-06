##rns.id/modules/database/outputs.tf

output "instance_id" {
  description = "The ID of the database instance."
  value       = google_sql_database_instance.db_instance.id
}
