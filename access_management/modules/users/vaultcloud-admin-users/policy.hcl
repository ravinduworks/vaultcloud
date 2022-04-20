# Read health checks
path "sys/health"{
  capabilities = ["read", "sudo"]
}

## Operations
# List audit backends
path "/sys/audit" {
 capabilities = ["read","list"]
}
# Create an audit backend. Operators are not allowed to remove them.
path "/sys/audit/*" {
 capabilities = ["create","read","list","sudo"]
}

# CORS configuration
path "/sys/config/cors" {
 capabilities = ["read", "list", "create", "update", "sudo"]
}
# Start root token generation
path "/sys/generate-root/attempt" {
 capabilities = ["read", "list", "create", "update", "delete"]
}

# Configure License
path "/sys/license" {
 capabilities = ["read", "list", "create", "update", "delete"]
}

#Get Cluster Leader
path "/sys/leader" {
 capabilities = ["read"]
}

# Manage auth methods broadly across Vault
path "auth/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Create, update, and delete auth methods
path "sys/auth/*" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

# List auth methods
path "sys/auth" {
  capabilities = ["read", "list"]
}

# GCP Auth
path "gcp/*" {
  capabilities = ["read", "list"]
}

path "gcp" {
  capabilities = ["read", "list"]
}

# To list approles
path "sys/approle" {
  capabilities = ["read", "list"]
}

# To list policies
path "sys/policy" {
  capabilities = ["read", "list"]
}

# View matrics
path "sys/metrics/*" {
  capabilities = ["read", "list"]
}

# To list policies
path "sys/metrics" {
  capabilities = ["read", "list"]
}

# List existing policies
path "sys/policies/acl" {
  capabilities = ["read", "list"]
}

# Manage policies
path "/sys/policies*" {
 capabilities = ["read", "list", "create", "update", "delete"]
}

## Audit
# Remove audit devices
path "/sys/audit/*" {
 capabilities = ["delete"]
}

# Hash values to compare with audit logs
path "/sys/audit-hash/*" {
 capabilities = ["create"]
}

# Read HMAC configuration for redacting headers
path "/sys/config/auditing/request-headers" {
 capabilities = ["read", "sudo"]
}

# Configure HMAC for redacting headers
path "/sys/config/auditing/request-headers/*" {
 capabilities = ["read", "list", "create", "update", "sudo"]
}

# Get Storage Key Status
path "/sys/key-status" {
 capabilities = ["read"]
}

# Submit Key for Re-keying purposes
path "/sys/rekey-recovery-key/update" {
 capabilities = ["create", "update"]
}

# Create and manage ACL policies broadly across Vault
path "sys/policy/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Verify update
path "/sys/rekey-recovery-key/verify" {
 capabilities = ["create", "update"]
}

# List, create, update, and delete key/value secrets
path "secret/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Manage secrets engines
path "sys/mounts/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Manage and manage secret backends broadly across Vault.
path "sys/mounts/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# To perform capabilities
path "sys/capabilities" {
  capabilities = ["create", "update"]
}

path "sys/capabilities-self" {
  capabilities = ["create", "update"]
}

# Allow managing leases
path "sys/leases/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# To retrieve the usage metrics
path "sys/internal/counters/activity" {
  capabilities = ["read"]
}

# To read and update the usage metrics configuration
path "sys/internal/counters/config" {
  capabilities = ["read", "update"]
}

# Groups specific access. When you add new users group under module directory
# we need to update namespace/mounts point here, so that Admin users will have
# access to the same.

path "vaultcloud" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "vaultcloud/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

