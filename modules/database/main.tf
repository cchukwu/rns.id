##rns.id/modules/database/main.tf

# Reserve a range for the private connection
resource "google_compute_global_address" "private_ip_address" {
  name          = "database-private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.vpc_id
}

# Establish a private connection for accessing Google services privately
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.vpc_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

# Define the SQL Database Instance
resource "google_sql_database_instance" "db_instance" {
  name             = var.instance_name
  database_version = var.database_version
  region           = var.region

  settings {
    tier = var.tier
  }

  # Ensure this resource depends on the private VPC connection being established.
  depends_on = [
    google_service_networking_connection.private_vpc_connection
  ]
}

