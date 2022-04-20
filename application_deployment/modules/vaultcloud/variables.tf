variable "num_vaultcloud_pods" {
  description = "Number of vaultcloud pods to create in GKE cluster"
  type    = number
  default = 3
}

variable "vaultcloud_version" {
  description = "Version of Hashicorp vaultcloud to use for this deployment"
  type = string
}

variable "project_id" {
  description = "The project ID to manage the Cloud SQL resources"
  type        = string
}

variable "unseal_keyring_name" {
  description = "Keyring name containing the GKMS key that will unseal vaultcloud"
  type        = string
}

variable "unseal_key_name" {
  description = "Name of key inside the unseal keyring that unseals the vaultcloud"
  type        = string
}

variable "unseal_account_name" {
  description = "Name of Service Account used to unseal vaultcloud with GKMS key"
  type        = string
}

variable "region" {
  description = "Region of the GCP in which resources will be provisioned"
  type = string
}

variable "loadbalancer_ip" {
  description = "IP Address of ingress to cluster"
  type        = string
}

variable "cluster_endpoint" {
  description = "GCP GKE cluster endpoint"
  type = string
}

variable "cluster_cert" {
  description = "GCP GKE cluster certificate"
  type = string
}

variable "vaultcloud_hostname" {
  description = "Hostname associated with TLS Cert"
  type        = string
}

variable "vaultcloud_tls_secret_resource" {
  description = "Link to k8s secret resource for the sake of creating a cross-module dependency"
}

variable "db_private_ip_address" {
  description = "IP Address of the DB"
  type = string
}

variable "db_username" {
  description = "The name of the default user"
  type        = string
  default     = "default"
}

variable "db_password" {
  description = "Database password"
  type = string
}

variable "vaultcloud_tls_k8s_secret" {
  description = "Kubernetes secret containing TLS cert files"
  type        = string
}

variable "oidc_secret_name" {
  description = "OIDC secret name to mount on the pod"
  type        = string
}

variable "ui_enabled" {
  description = "True if you want to create vaultcloud UI, otherwise False"
  type        = bool
}

variable "helm_release_name" {
  type        = string
  description = "The name of the Helm release"
  default     = "vault"
}

variable "helm_chart_name" {
  type        = string
  description = "The chart name in the Helm repository"
  default     = "vault"
}

variable "helm_repository" {
  type        = string
  description = "The location of the Helm repository"
  default     = "https://helm.releases.hashicorp.com/"
}