# For new deployment change cluster name, kms keyring name and database name. 
# Project 
project_id       = <google project id>
credentials_file = <google service account>
region           = <google project region>
cluster_zone     = <google project zone>
network          = <project VPC network>
subnetwork       = <google project subnetwork>

# GKE 
node_count = 1 
num_vaultcloud_pods = 3 
cluster_ipv4_cidr_block = "10.116.48.0/20" 
services_ipv4_cidr_block = "10.115.41.0/24" 
gke_cluster_labels = { "app" : "cloudvault", "team" : "devops" } 
cluster_name = "vaultcloud" 
vaultcloud_version = "1.8.0"

# UI is disable by default
ui_enabled = true

# DNS 
vaultcloud_hostname = <FQDN for Vault>

# Database 
cloudsql_name = "vaultcloud" 
db_name = "vaultcloud-db" 
db_username = "vaultcloud-db" 
db_schema_bucket = <GCS bucket name where sql schema file is located example: <bucketname>/db-schema/vaultcloud-db-schema.sql>
db_cluster_zone = <google project zone>
database_labels = { "app" : "vaultcloud", "team" : "devops" } 

# KMS 
gcpkms_service_account = "vaultcloud-gcpkms" 
keyring_name = "vaultcloud-unseal-keyring" 
key_name = "vaultcloud-unseal-key" 

# Static IP 
external_static_ip_name = "vaultcloud-external-ip" 

# TLS  
vaultcloud_key = "tls/vaultcloud.key" 
vaultcloud_cert = "tls/vaultcloud.cert" 
vaultcloud_secret_name = "vaultcloud-tls"

# OIDC 
oidc_secret_name = "oidc" 
oidc_service_account = <google OIDC service account>
