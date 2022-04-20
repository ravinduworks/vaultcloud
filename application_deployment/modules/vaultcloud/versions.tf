terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    helm = {
      source = "hashicorp/helm"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    acme = {
      source = "vancluever/acme"
      version = "~> 2.6.0"
    }
  }
  required_version = ">= 0.14"
}
