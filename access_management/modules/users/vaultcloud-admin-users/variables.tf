variable "oidc_path" {
  description = "Path to mount the JWT/OIDC auth backend"
  type = string
  default = "oidc"
}

variable "auth_type" {
  description = "Type of auth backend. Should be one of jwt or oidc."
  type = string
  default = "oidc"
}

variable "oauth_client_id" {
  description = "OAuth 2.0 client ID from the Google API Console Credentials in APIs & Services"
  type = string
}

variable "token_accessor" {
  description = "This accessor is a value that acts as a reference to a token"
  type = string
}

variable "hostname" {
  description = "VaultCloud hostname (DNS)"
  type = string
}