
// Master
output "instance_name" {
  value       = google_sql_database_instance.default.name
  description = "The instance name for the master instance"
}

output "public_ip_address" {
  value       = google_sql_database_instance.default.public_ip_address
  description = "The first public (PRIMARY) IPv4 address assigned for the master instance"
}

output "private_ip_address" {
  value       = google_sql_database_instance.default.private_ip_address
  description = "The first private (PRIVATE) IPv4 address assigned for the master instance"
}

output "instance_ip_address" {
  value       = google_sql_database_instance.default.ip_address
  description = "The IPv4 address assigned for the master instance"
}

output "instance_first_ip_address" {
  value       = google_sql_database_instance.default.first_ip_address
  description = "The first IPv4 address of the addresses assigned."
}

output "instance_connection_name" {
  value       = google_sql_database_instance.default.connection_name
  description = "The connection name of the master instance to be used in connection strings"
}

output "instance_self_link" {
  value       = google_sql_database_instance.default.self_link
  description = "The URI of the master instance"
}

output "instance_server_ca_cert" {
  value       = google_sql_database_instance.default.server_ca_cert
  description = "The CA certificate information used to connect to the SQL instance via SSL"
}

output "instance_service_account_email_address" {
  value       = google_sql_database_instance.default.service_account_email_address
  description = "The service account email address assigned to the master instance"
}

// Replicas
output "replicas_instance_first_ip_addresses" {
  value       = google_sql_database_instance.replicas.ip_address
  description = "The first IPv4 addresses of the addresses assigned for the replica instances"
}

output "replicas_instance_connection_names" {
  value       = google_sql_database_instance.replicas.connection_name
  description = "The connection names of the replica instances to be used in connection strings"
}

output "replicas_instance_self_links" {
  value       = google_sql_database_instance.replicas.self_link
  description = "The URIs of the replica instances"
}

output "replicas_instance_server_ca_certs" {
  value       = google_sql_database_instance.replicas.server_ca_cert
  description = "The CA certificates information used to connect to the replica instances via SSL"
}

output "replicas_instance_service_account_email_addresses" {
  value       = google_sql_database_instance.replicas.service_account_email_address
  description = "The service account email addresses assigned to the replica instances"
}

output "read_replica_instance_names" {
  value       = google_sql_database_instance.replicas.name
  description = "The instance names for the read replica instances"
}

output "generated_user_password" {
  value       = random_id.user-password.hex
  sensitive   = true
  description = "The auto generated default user password if not input password was provided"
}

output "db_password" {
  value       = random_id.user-password.hex
  sensitive   = true
  description = "The auto generated default user password if not input password was provided"
}


// Resources
output "primary" {
  sensitive = true
  value       = google_sql_database_instance.default
  description = "The `google_sql_database_instance` resource representing the primary instance"
}

output "replicas" {
  sensitive = true
  value       = values(google_sql_database_instance.replicas)
  description = "A list of `google_sql_database_instance` resources representing the replicas"
}

output "instances" {
  sensitive = true
  value       = concat(
    [
      google_sql_database_instance.default
      ], 
      values
      (
        google_sql_database_instance.replicas
        )
        )
  description = "A list of all `google_sql_database_instance` resources we've created"
}