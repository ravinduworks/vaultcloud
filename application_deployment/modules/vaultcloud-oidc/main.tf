# This service account is going to be used for configuring Google Suite OIDC 
# for vaultcloud end user access. Service account is configured with Google 
# Workspace domain-wide delegation of authority. Google service account should 
# be capable of making requests to the G Suite User Accounts and Groups APIs. 

resource "kubernetes_secret" "oidc-service-account" {
  metadata {
    name      = var.oidc_secret_name
    namespace = var.vaultcloud_namespace
  }

  data = {
    "oidc-service-account.json" = file("${var.oidc_service_account}")
  }

  type = "Opaque"
}