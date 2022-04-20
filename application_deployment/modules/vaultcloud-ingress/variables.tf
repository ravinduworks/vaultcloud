variable "project_id" {
  description = "Project ID of the GCP project in which resources will be created"
  type = string
}

variable "region" {
  description = "Region of the GCP in which resources will be "
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

variable "vaultcloud_namespace" {
  description = "GKE namespace where vaultcloud application is running"
  type = string
}