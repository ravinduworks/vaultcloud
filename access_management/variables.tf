variable "hostname" {
  description = "VaultCloud hostname (DNS). It should be the configured in Helm"
  type = string
}

variable "oidc_path" {
  description = "Path to mount the JWT/OIDC auth backend"
  type = string
}

variable "oidc_auth_type" {
  description = "Type of auth backend. Should be one of jwt or oidc."
  type = string
  default = "oidc"
}

variable "oauth_client_id" {
  description = "OAuth 2.0 client ID from the Google API Console Credentials in APIs & Services"
  type = string
}

variable "oauth_client_secret" {
  description = "OAuth 2.0 client secret from the Google API Console Credentials in APIs & Services"
  type = string
}

variable "gsuite_admin_impersonate" {
  description = "Gsuite admin account to impersonate"
  type = string
}

variable "gitlab_jwt_path" {
  description = "Path to mount the Gitlab JWT auth backend"
  type = string
  default = "jwt"
}

variable "gitlab_jwks_url" {
  description = "Gitlab JWKS endpoint to validate the token"
  type = string
}

variable "gitlab_bound_issuer" {
  description = "Gitlab bound issuer endpoint"
  type = string
}

