# Create a policy which allows users to access namespace
resource "vault_policy" "vaultcloud-engplatform-releaseeng_policy" {
  name   = "vaultcloud-engplatform-releaseeng"
  policy = file("modules/users/vaultcloud-engplatform-releaseeng/policy.hcl")
}

# Create a GSuite Auth backend to allow users to authenticate via OIDC
resource "vault_jwt_auth_backend_role" "vaultcloud-engplatform-releaseeng" {
  backend               =   var.oidc_path
  role_name             =   "vaultcloud-engplatform-releaseeng"
  token_policies        =   ["vaultcloud-engplatform-releaseeng"]
  token_ttl             =   3600
  token_max_ttl         =   14400
  user_claim            =   "sub"
  groups_claim          =   "groups"
  bound_claims          =   {"groups" = "vaultcloud-engplatform-releaseeng@example.com"}
  bound_claims_type     =   "string"
  bound_audiences       =   [var.oauth_client_id]
  allowed_redirect_uris = [
    "https://${var.hostname}:8200/ui/vault/auth/${var.oidc_path}/oidc/callback",
    "http://localhost:8250/oidc/callback",
  ]
}

# Link the policy to the domain users group
resource "vault_identity_group" "vaultcloud-engplatform-releaseeng" {
  name = "vaultcloud-engplatform-releaseeng"
  type = "external"
  policies = ["vaultcloud-engplatform-releaseeng"]
  metadata = {
    responsibility = "vaultcloud Release Eng Users Group"
  }
}

# Creates an Identity Group Alias for vaultcloud
resource "vault_identity_group_alias" "vaultcloud-engplatform-releaseeng" {
  name           = "vaultcloud-engplatform-releaseeng"
  mount_accessor = var.token_accessor
  canonical_id   = vault_identity_group.vaultcloud-engplatform-releaseeng.id
}

# Mount a valumes to access secrets for the group
resource "vault_mount" "vaultcloud-engplatform-releaseeng-kv" {
  path        = "vaultcloud/vaultcloud-engplatform-releaseeng/kv"
  type        = "kv-v2"
  description = "KV2 Secrets Engine for vaultcloud-engplatform-releaseeng."
}