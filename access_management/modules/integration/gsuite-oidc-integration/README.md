#  GSuite OIDC Integration

----

GSuite OIDC can be integrated with vaultcloud to authenticate human users, using Google GSuite as our IDP has the advantage that we do not need to provide users with an additional set of user credentials that they could lose.

----

## Document to follow OIDC integration

* https://www.vaultproject.io/docs/auth/jwt/oidc_providers#google

## Configuration

There is an error with vault provider `vault_jwt_auth_backend`, manually update this from command line to make sure it is setting all params correctly and ignore changes until fixed.

https://github.com/hashicorp/terraform-provider-vault/issues/957


```text
   vault write auth/oidc/config -<<EOF
   {
       "oidc_discovery_url": "https://accounts.google.com",
       "oidc_client_id": "<your oidc client id goes here>",
       "oidc_client_secret": "<your oidc secret goes here>",
       "default_role": "default_role",
       "provider_config": {
           "provider": "gsuite",
           "gsuite_service_account": "/vault/userconfig/oidc/oidc-service-account.json",
           "gsuite_admin_impersonate": "vaultcloud@example.com",
           "fetch_groups": true,
           "fetch_user_info": true,
           "groups_recurse_max_depth": 5
       }
   }
   EOF
   
```