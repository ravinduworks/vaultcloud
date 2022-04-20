# Adding this module to enable GCP secret engine at initial deployment.
resource "vault_gcp_secret_backend" "gcp" {
    description = "Enable GCP Secret Engine at default PATH"
    path                      = "gcp/default"
}
