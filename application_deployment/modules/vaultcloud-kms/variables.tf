variable "project_id" {
  description = "Project ID of the GCP project in which resources will be created"
  type = string
}
variable "region" {
  description = "Region of the GCP in which resources will be "
  type = string
}

variable "key_name" {
  description = "GCP Cloud KMS key name"
  type        = string
  default     = "default"
}

variable "keyring_name" {
  description = "GCP KMS keyring name"
  type        = string
  default     = "default"
}

variable "keyring_location" {
  description = "Location of the GCP KMS keyring"
  type    = string
  default = "global"
}

variable "gcpkms_service_account" {
  description = "Create Service Account for vaultcloud to fetch unseal keyse"
  type        = string
  default     = "default"
}

variable "service_account_iam_roles" {
  description = "List of IAM roles to assign to the service account."
  type = list(string)
  default = [
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/iam.serviceAccountKeyAdmin",
    "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  ]
}
