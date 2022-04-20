data "google_client_config" "current" {
}

data "kubernetes_service" "vaultcloud_svc" {
  depends_on = [
    helm_release.vaultcloud
  ]

  metadata {
    namespace = "vaultcloud"
    name      = "vault-ui"
  }
}

