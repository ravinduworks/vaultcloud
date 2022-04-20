variable "project_id" {
  description = "Project ID of the GCP project in which resources will be created"
  type = string
}

variable "region" {
  description = "Region of the GCP in which resources will be "
  type = string
}

variable "cluster_location" {
  description = "GCP zone in which to instantiate the Kubernetes cluster"
  type = string
}

variable "cluster_name" {
  description = "Name to use for the vaultcloud GKE cluster"
  type = string
}

variable "node_count" {
  description = "Number of nodes in vaultcloud needs to deployed"
  type = number
}

variable "network" {
  description = "Network in which GCP resources will be created"
  type        = string
}

variable "subnetwork" {
  description = "Subnetwork name in which GCP resources will be created"
  type        = string
}

variable "node_machine_type" {
  description = "GCP machine type family"
  type    = string
  default = "n1-standard-1"
}

variable "node_image_type" {
  description = "Node image type"
  type    = string
  default = "COS"
}

variable "unseal_service_account" {
  description = "GCP IAM Service Account which require to unseal vaultcloud service"
  type = string
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