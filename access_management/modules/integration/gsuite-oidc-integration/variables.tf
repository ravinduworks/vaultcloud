variable "oidc_path" {
  description = "Path to mount the JWT/OIDC auth backendh"
  type = string
}

variable "oidc_auth_type" {
  description = "Type of auth backend. Should be one of jwt or oidc."
  type = string
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

variable "hostname" {
  description = "VaultCloud hostname (DNS)"
  type = string
}