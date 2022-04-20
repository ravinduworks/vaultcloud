variable "gitlab_jwt_path" {
  description = "Path to mount the Gitlab JWT auth backend"
  type = string
}

variable "gitlab_jwks_url" {
  description = "Gitlab JWKS endpoint to validate the token"
  type = string
}

variable "gitlab_bound_issuer" {
  description = "Gitlab bound issuer endpoint"
  type = string
}