data "google_client_config" "current" {
}

data "kubernetes_service" "nginx_ingress_controller" {
  depends_on = [helm_release.nginx]

  metadata {
    name      = "${helm_release.nginx.metadata[0].name}-controller"
  }
}