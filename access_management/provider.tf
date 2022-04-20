provider "vault" {}

provider "google" {
  credentials = file("service-account.json")
  project     = var.project_id
  region      = var.region
}

provider "google-beta" {
  credentials = file("service-account.json")
  project     = var.project_id
  region      = var.region
}