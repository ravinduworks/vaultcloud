resource "vault_jwt_auth_backend" "gitlab" {
    description         = "JWT Authentication method for Gitlab"
    path                = var.gitlab_jwt_path
    jwks_url            = var.gitlab_jwks_url
    bound_issuer        = var.gitlab_bound_issuer
}

