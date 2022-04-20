# Integration Configurations
module "oidc_integration" {
  source                    = "./modules/integration/gsuite-oidc-integration"
  hostname                  = var.hostname
  oidc_path                 = var.oidc_path
  oidc_auth_type            = var.oidc_auth_type
  oauth_client_id           = var.oauth_client_id
  oauth_client_secret       = var.oauth_client_secret
  gsuite_admin_impersonate  = var.gsuite_admin_impersonate
}

module "gitlab_integration" {
  source                = "./modules/integration/gitlab-jwt-integration"
  gitlab_jwt_path       = var.gitlab_jwt_path
  gitlab_jwks_url       = var.gitlab_jwks_url
  gitlab_bound_issuer   = var.gitlab_bound_issuer
}

module "gcp_iam_integration" {
  source                        = "./modules/integration/gcp-iam-integration"
}

# Systems configurations


# User configurations
module "vaultcloud-admin-users" {
  source              = "./modules/users/vaultcloud-admin-users"
  hostname            = var.hostname
  oidc_path           = var.oidc_path
  oauth_client_id     = var.oauth_client_id
  token_accessor      = module.oidc_integration.token_accessor
}

module "vaultcloud-engplatform-devops" {
  source              = "./modules/users/vaultcloud-engplatform-devops"
  hostname            = var.hostname
  oidc_path           = var.oidc_path
  oauth_client_id     = var.oauth_client_id
  token_accessor      = module.oidc_integration.token_accessor
}

module "vaultcloud-engplatform-releaseeng" {
  source              = "./modules/users/vaultcloud-engplatform-releaseeng"
  hostname            = var.hostname
  oidc_path           = var.oidc_path
  oauth_client_id     = var.oauth_client_id
  token_accessor      = module.oidc_integration.token_accessor
}

module "vaultcloud-dataeng-developers" {
  source              = "./modules/users/vaultcloud-dataeng-developers"
  hostname            = var.hostname
  oidc_path           = var.oidc_path
  oauth_client_id     = var.oauth_client_id
  token_accessor      = module.oidc_integration.token_accessor
}