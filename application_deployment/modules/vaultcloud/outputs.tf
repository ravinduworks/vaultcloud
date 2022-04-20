output "vaultcloud_namespace" {
  value = kubernetes_namespace.vaultcloud.metadata.0.name
}

// output "vaultcloud_url" {
//   value = "https://${data.kubernetes_service.vaultcloud_svc.status.0.load_balancer.0.ingress.0.ip}:8200"
// }