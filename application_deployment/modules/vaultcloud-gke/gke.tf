resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  project  = var.project_id
  location = var.cluster_location

  min_master_version = "1.21"

  initial_node_count       = var.node_count
  remove_default_node_pool = true

  resource_labels = var.gke_cluster_labels
  
  network    = var.network
  subnetwork = var.subnetwork

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = var.cluster_ipv4_cidr_block
    services_ipv4_cidr_block = var.services_ipv4_cidr_block
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }

  enable_binary_authorization = true
}

resource "google_container_node_pool" "vaultcloud_node_pool" {
  name       = "vaultcloud-node-pool"
  location   = var.cluster_location
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count

  node_config {
    service_account = var.unseal_service_account
    machine_type    = var.node_machine_type
    image_type      = var.node_image_type
    labels          = var.gke_cluster_labels

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloudkms",
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
