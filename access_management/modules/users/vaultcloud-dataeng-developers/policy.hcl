path "vaultcloud/vaultcloud-dataeng-developers/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Permission to create gitlab roles to fetch secret from GitLab CICD
path "auth/jwt/gitlab/role/*" {
  capabilities = ["create", "read", "update", "list", "delete"]
}

# Manage GCP secret backends.
path "sys/mounts/vaultcloud/vaultcloud-dataeng-developers/gcp/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# List GCP Secret Engine.
# NOTE: Do not provide more than `list` and `read` permissions for this
# end users.
path "sys/mounts" {
  capabilities = ["list", "read"]
}