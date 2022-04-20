terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.5.0"
    }
  }
  required_version = ">= 0.14"
}
