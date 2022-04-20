# VaultCloud Access Management


----

Before a client can interact with VaultCloud to get a secret or a temporary GCP service account, it must authenticate against an auth method to acquire a VaultCloud native token. To authenticate against an auth method, the administrator must provide access to the client. There are two types of clients - systems and humans. 

Systems & services need to be onboarded to the VaultCloud, before they start reading secrets from it. For example, in order to pull secrets from VaultCloud and inject them into the Gitlab pipeline, administrators must integrate Gitlab with VaultCloud, which uses JWT based authentication.

Similarly, GSuite OIDC is integrated with VaultCloud to authenticate human users, using Google GSuite as our IDP has the advantage that we do not need to provide users with an additional set of user credentials that they could lose.

----

## Prerequisites

* Terraform v1 or later
* VaultCloud should be up and running

## Configuration

These parameters are required to be updated in terraform tfvars file. 

- `hostname` - Domain name of the VaultCloud
- `oauth_client_id` - Get OAuth client ID from Google API Console. https://console.developers.google.com/
- `oauth_client_secret` - - Get OAuth client secret from Google API Console. https://console.developers.google.com/
- `oidc_path` - Path where GSuite OIDC integration needs to be configured and stored in VaultCloud.
- `gitlab_jwt_path` - Path where Gitlab integration needs to be configured and stored in VaultCloud.
- `gitlab_jwks_url` - GitLab SON Web Key Set (JWKS) URL (and optional certificate chain) is configured. Keys will be fetched from this endpoint during authentication.
- `gitlab_bound_issuer` - URL of bound issuer. Bound_issuer specifies that only a JWT with the issuer (that is, the iss claim) set to gitlab.example.com can use this method to authenticate, and that the JWKS endpoint (https://gitlab.example.com/-/jwks) should be used to validate the token.


## Deployment

1. Download and install [Terraform](https://www.terraform.io/).

2. Download, install, and configure the [Google Cloud SDK](https://cloud.google.com/sdk/docs/quickstart). You will need
   to configure your default application credentials so Terraform can run. 

3. Run Terraform:

    ```text
    $ cd terraform/
    $ terraform init
    $ terraform apply
    ```

## Need help? 

Please connect with developers at vaultcloud@example.com or slack channel at #vaultsupport

