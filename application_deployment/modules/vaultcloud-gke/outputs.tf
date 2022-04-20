output "endpoint" {
  sensitive   = true
  description = "Cluster endpoint"
  value       = google_container_cluster.primary.endpoint
  depends_on = [
    google_container_cluster.primary,
  ]
}

output "ca_certificate" {
  sensitive   = true
  description = "Cluster ca certificate (base64 encoded)"
  value       = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
}