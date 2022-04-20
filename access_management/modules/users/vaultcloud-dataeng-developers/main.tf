# Create a policy which allows users to access namespace
resource "vault_policy" "vaultcloud-dataeng-developers_policy" {
  name   = "vaultcloud-dataeng-developers"
  policy = file("modules/users/vaultcloud-dataeng-developers/policy.hcl")
}

# Create a GSuite Auth backend to allow users to authenticate via OIDC
resource "vault_jwt_auth_backend_role" "vaultcloud-dataeng-developers" {
  backend               =   var.oidc_path
  role_name             =   "vaultcloud-dataeng-developers"
  token_policies        =   ["vaultcloud-dataeng-developers"]
  token_ttl             =   3600
  token_max_ttl         =   14400
  user_claim            =   "sub"
  groups_claim          =   "groups"
  bound_claims          =   {"groups" = "vaultcloud-dataeng-developers@example.com"}
  bound_claims_type     =   "string"
  bound_audiences       =   [var.oauth_client_id]
  allowed_redirect_uris = [
    "https://${var.hostname}:8200/ui/vault/auth/${var.oidc_path}/oidc/callback",
    "http://localhost:8250/oidc/callback",
  ]
}

# Link the policy to the domain users group
resource "vault_identity_group" "vaultcloud-dataeng-developers" {
  name = "vaultcloud-dataeng-developers"
  type = "external"
  policies = ["vaultcloud-dataeng-developers"]
  metadata = {
    responsibility = "VaultCloud Data Eng Users Group"
  }
}

# Creates an Identity Group Alias for VaultCloud
resource "vault_identity_group_alias" "vaultcloud-dataeng-developers" {
  name           = "vaultcloud-dataeng-developers"
  mount_accessor = var.token_accessor
  canonical_id   = vault_identity_group.vaultcloud-dataeng-developers.id
}

# Mount a valume to access for the group
resource "vault_mount" "vaultcloud-dataeng-developers-kv" {
  path        = "vaultcloud/vaultcloud-dataeng-developers/kv"
  type        = "kv-v2"
  description = "KV2 Secrets Engine for vaultcloud-dataeng-developers."
}