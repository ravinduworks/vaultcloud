# OIDC Integration document - https://www.vaultproject.io/docs/auth/jwt/oidc_providers#google

resource "vault_jwt_auth_backend" "gsuite" {
    description = "OIDC GSuite backend"
    oidc_discovery_url = "https://accounts.google.com"
    path = var.oidc_path
    type = var.oidc_auth_type
    oidc_client_id = var.oauth_client_id
    oidc_client_secret = var.oauth_client_secret
    default_role = "default_role"
    provider_config = {
        provider = "gsuite"
        gsuite_service_account = "/vault/userconfig/oidc/oidc-service-account.json"
        gsuite_admin_impersonate = var.gsuite_admin_impersonate
        fetch_groups = true
        fetch_user_info = true
        groups_recurse_max_depth = 5
        # Manually update this from command line to make sure it is setting all
        # params correctly and ignore changes until fixed.
        # https://github.com/hashicorp/terraform-provider-vault/issues/957
        # fetch_groups = true
        # fetch_user_info = false
        # groups_recurse_max_depth = 5

        # EXAMPLE: RUN THIS IN THE TERMINAL BY CONNECTNG TO VAULT
        # vault write auth/oidc/config -<<EOF
        # {
        #     "oidc_discovery_url": "https://accounts.google.com",
        #     "oidc_client_id": "<your oidc client id goes here>",
        #     "oidc_client_secret": "<your oidc secret goes here>",
        #     "default_role": "default_role",
        #     "provider_config": {
        #         "provider": "gsuite",
        #         "gsuite_service_account": "/vault/userconfig/oidc/oidc-service-account.json",
        #         "gsuite_admin_impersonate": "vaultcloud@example.com",
        #         "fetch_groups": true,
        #         "fetch_user_info": true,
        #         "groups_recurse_max_depth": 5
        #     }
        # }
        # EOF
    }

    lifecycle {
        ignore_changes = [
        provider_config,
        ]
    }
}

resource "vault_jwt_auth_backend_role" "default_role" {
  backend   = "${vault_jwt_auth_backend.gsuite.path}"
  role_name = "default_role"
  role_type = vault_jwt_auth_backend.gsuite.type
  allowed_redirect_uris = [
    "https://${var.hostname}:8200/ui/vault/auth/${var.oidc_path}/oidc/callback",
    "http://localhost:8250/oidc/callback",
  ]
  user_claim   = "sub"
  groups_claim = "groups"
  # Domain users get default policy always
  token_policies = ["default"]
}
