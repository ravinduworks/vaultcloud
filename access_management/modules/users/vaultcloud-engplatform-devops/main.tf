# Create a policy which allows users to access namespace
resource "vault_policy" "vaultcloud-engplatform-devops_policy" {
  name   = "vaultcloud-engplatform-devops"
  policy = file("modules/users/vaultcloud-engplatform-devops/policy.hcl")
}

# Create a GSuite Auth backend to allow users to authenticate via OIDC
resource "vault_jwt_auth_backend_role" "vaultcloud-engplatform-devops" {
  backend               =   var.oidc_path
  role_name             =   "vaultcloud-engplatform-devops"
  token_policies        =   ["vaultcloud-engplatform-devops"]
  token_ttl             =   3600
  token_max_ttl         =   14400
  user_claim            =   "sub"
  groups_claim          =   "groups"
  bound_claims          =   {"groups" = "vaultcloud-engplatform-devops@example.com"}
  bound_claims_type     =   "string"
  bound_audiences       =   [var.oauth_client_id]
  allowed_redirect_uris = [
    "https://${var.hostname}:8200/ui/vault/auth/${var.oidc_path}/oidc/callback",
    "http://localhost:8250/oidc/callback",
  ]
}

# Link the policy to the domain users group
resource "vault_identity_group" "vaultcloud-engplatform-devops" {
  name = "vaultcloud-engplatform-devops"
  type = "external"
  policies = ["vaultcloud-engplatform-devops"]
  metadata = {
    responsibility = "vaultcloud DevOps Users Group"
  }
}

# Creates an Identity Group Alias for vaultcloud
resource "vault_identity_group_alias" "vaultcloud-engplatform-devops" {
  name           = "vaultcloud-engplatform-devops"
  mount_accessor = var.token_accessor
  canonical_id   = vault_identity_group.vaultcloud-engplatform-devops.id
}

# Mount a valume to access for the group
resource "vault_mount" "vaultcloud-engplatform-devops-kv" {
  path        = "vaultcloud/vaultcloud-engplatform-devops/kv"
  type        = "kv-v2"
  description = "KV2 Secrets Engine for vaultcloud-engplatform-devops."
}