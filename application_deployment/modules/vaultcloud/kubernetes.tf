resource "kubernetes_namespace" "vaultcloud" {
  metadata {
    name = "vaultcloud"
  }
  depends_on = [var.cluster_endpoint]
}
