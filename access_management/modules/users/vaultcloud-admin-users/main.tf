# ADMIN GROUP
# Admin users will not have any mount points and namespace attached. This group 
# has FULL access to VaultCloud and can do all types of operations. 

# Create a policy which allows users to access namespace
resource "vault_policy" "vaultcloud_admin_users_policy" {
  name   = "vaultcloud-admin-users"
  policy = file("modules/users/vaultcloud-admin-users/policy.hcl")
}

# Create a GSuite Auth backend to allow users to authenticate via OIDC
resource "vault_jwt_auth_backend_role" "vaultcloud-admin-users" {
  backend               =   var.oidc_path
  role_name             =   "vaultcloud-admin-users"
  token_policies        =   ["vaultcloud-admin-users"]
  token_ttl             =   3600
  token_max_ttl         =   14400
  user_claim            =   "sub"
  groups_claim          =   "groups"
  bound_claims          =   {"groups" = "vaultcloud-admin-users@example.com"}
  bound_claims_type     =   "string"
  bound_audiences       =   [var.oauth_client_id]
  allowed_redirect_uris = [
    "https://${var.hostname}:8200/ui/vault/auth/${var.oidc_path}/oidc/callback",
    "http://localhost:8250/oidc/callback",
  ]
}

# Link the vaultcloud admin policy to the domain admin group
resource "vault_identity_group" "vaultcloud-admin-users" {
  name = "vaultcloud-admin-users"
  type = "external"
  policies = ["vaultcloud-admin-users"]
  metadata = {
    responsibility = "vaultcloud Admins Users Group"
  }
}

# Creates an Identity Group Alias for vaultcloud
resource "vault_identity_group_alias" "vaultcloud-admin-users" {
  name           = "vaultcloud-admin-users"
  mount_accessor = var.token_accessor
  canonical_id   = vault_identity_group.vaultcloud-admin-users.id
}
