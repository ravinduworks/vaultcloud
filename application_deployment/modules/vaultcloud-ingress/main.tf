resource "kubernetes_namespace" "vaultcloud-ingress" {
  metadata {
    name = "vaultcloud-ingress"
  }
}

# Using the "Kubernetes Ingres NGINX" https://github.com/kubernetes/ingress-nginx
resource "helm_release" "nginx" {
  name = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart  = "ingress-nginx"
  version = "3.35.0"
  create_namespace = false
  namespace = kubernetes_namespace.vaultcloud-ingress.metadata.0.name
  force_update = true

  values = [ <<EOF
fullnameOverride: "vaultcloud-nginx"
rbac:
  create: true
controller:
  name: "vaultcloud-nginx"
  ingressClass: "nginx"
  extraArgs:
    enable-ssl-passthrough: true
service:
  externalTrafficPolicy: "Local"
tcp:
  8200: "${var.vaultcloud_namespace}/vault-active:8200"
EOF
  ]
}

resource "time_sleep" "wait_60_seconds" {
  depends_on = [
    helm_release.nginx,
  ]
  create_duration = "60s"
}

