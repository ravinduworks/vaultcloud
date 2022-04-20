# Cluster Information
variable "project_id" {
  description = "Project ID of the GCP project in which resources will be created"
  type        = string
}

variable "region" {
  description = "Region of the GCP in which resources will be provisioned"
  type        = string
}

variable "network" {
  description = "Network in which GCP resources will be created"
  type        = string
}

variable "subnetwork" {
  description = "Subnetwork name in which GCP resources will be created"
  type        = string
}

variable "cluster_zone" {
  description = "GCP zone in which to instantiate the Kubernetes cluster"
  type        = string
}

variable "cluster_name" {
  description = "Name to use for the vaultcloud GKE cluster"
  type        = string
}

variable "credentials_file" {
  description = "Path to GCP Credentials JSON file"
  type        = string
}

variable "cluster_ipv4_cidr_block" {
  description = "The IP address range for the cluster pod IPs."
  type = string
}

variable "services_ipv4_cidr_block" {
  description = "The IP address range of the services IPs"
  type = string
}


variable "gke_cluster_labels" {
  description = "The key/value labels for the GKE Cluster."
  type        = map(string)
  default     = {}
}

# Application Information
variable "num_vaultcloud_pods" {
  description = "Number of vaultcloud pods to create in GKE cluster"
  type        = number
  default     = 3
}

variable "node_count" {
  description = "Number of nodes in vaultcloud needs to deployed"
  type = number
}

variable "vaultcloud_hostname" {
  description = "Domain name to use for FortkKnox"
  type        = string
}

variable "vaultcloud_version" {
  description = "Version of vaultcloud to use (e.g. '1.7.0')"
  type        = string
}

variable "ui_enabled" {
  description = "True if you want to create vaultcloud UI, otherwise False"
  type        = bool
}

# Database Infortmation
variable "cloudsql_name" {
  description = "The name of the Cloud SQL resources"
  type        = string
}

variable "database_labels" {
  description = "The key/value labels for the DB cluster instances."
  type        = map(string)
  default     = {}
}

variable "db_name" {
  description = "The name of the default database to create"
  type        = string
  default     = "default"
}

variable "db_username" {
  description = "The name of the default user"
  type        = string
  default     = "default"
}

variable "db_schema_bucket" {
  description = "GCP Cloud storage bucket to import DB schema file"
}

variable "db_cluster_zone" {
  description = "The zone for the master instance, it should be something like: `us-central1-a`, `us-east1-c`."
  type        = string
  default = "asia-east1-a"
}

# GCP KMS Information
variable "keyring_name" {
  description = "GCP KMS keyring name"
  type        = string
  default     = "default"
}

variable "key_name" {
  description = "GCP Cloud KMS key name"
  type        = string
  default     = "default"
}

variable "gcpkms_service_account" {
  description = "Create Service Account for vaultcloud to fetch unseal keys"
  type        = string
  default     = "default"
}

variable "external_static_ip_name" {
  description = "Create External Static IP"
  type        = string
  default     = "default"
}

# SSL/TLS
variable "vaultcloud_key" {
  description = "vaultcloud Key"
  type        = string
}

variable "vaultcloud_cert" {
  description = "cert"
  type        = string
}

variable "vaultcloud_secret_name" {
  description = "Name to use for the k8s secret containing the TLS cert/key"
  type        = string
}

# OIDC
variable "oidc_secret_name" {
  description = "OIDC secret name to mount on the pod"
  type        = string
}

variable "oidc_service_account" {
  description = "OIDC service account name"
  type        = string
}
