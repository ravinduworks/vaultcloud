variable "project_id" {
  description = "Project ID of the GCP project in which resources will be created"
  type = string
}

variable "region" {
  description = "Region of the GCP in which resources will be "
  type = string
}

variable "external_static_ip_name" {
  description = "Create External Static IP"
  type        = string
  default     = "default"
}