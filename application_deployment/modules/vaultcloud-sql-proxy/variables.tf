variable "project_id" {
  description = "Project ID of the GCP project in which resources will be created"
  type = string
}

variable "region" {
  description = "Region of the GCP in which resources will be "
  type = string
}

variable "cloudsql_name" {
  description = "The name of the Cloud SQL resources"
  type        = string
}

variable "vaultcloud_namespace" {
  description = "GKE namespace where vaultcloud application is running"
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

variable "credentials_file" {
  description = "Path to GCP Credentials JSON file"
  type        = string
}

variable "helm_chart" {
  type        = string
  description = "The location of the Helm chart"
  default     = "https://charts.rimusz.net"
}

variable "helm_release_name" {
  type        = string
  description = "The name of the Helm release"
  default     = "pg-sqlproxy"
}

variable "helm_chart_version" {
  type        = string
  description = "The chart name in the Helm repository"
  default     = "0.20.6"
}