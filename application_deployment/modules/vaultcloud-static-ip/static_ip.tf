resource "google_compute_address" "vaultcloud_ext_ip_address" {
    name        = var.external_static_ip_name
    project     = var.project_id
    region      = var.region
}