variable "vaultcloud_namespace" {
  description = "GKE namespace where vaultcloud application is running"
  type = string
}

variable "oidc_service_account" {
  description = "The name to service account which is configured"
  type        = string
}

variable "oidc_secret_name" {
  description = "OIDC secret name to mount"
  type = string
}

variable "cluster_endpoint" {
  description = "GCP GKE cluster endpoint"
  type = string
}

variable "cluster_cert" {
  description = "GCP GKE cluster certificate"
  type = string
}