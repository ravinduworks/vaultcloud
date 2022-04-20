# GKE cluster setup
module "vaultcloud-gke-cluster" {
  source                      = "./modules/vaultcloud-gke"
  region                      = var.region
  project_id                  = var.project_id
  cluster_name                = var.cluster_name
  cluster_location            = var.cluster_zone
  network                     = var.network
  subnetwork                  = var.subnetwork
  node_count                  = var.node_count
  gke_cluster_labels          = var.gke_cluster_labels
  cluster_ipv4_cidr_block     = var.cluster_ipv4_cidr_block
  services_ipv4_cidr_block    = var.services_ipv4_cidr_block
  unseal_service_account      = module.unseal_kms.service_account
}

# Provision external static IP address
module "vaultcloud_external_ip_address" {
  source                    = "./modules/vaultcloud-static-ip"
  project_id                = var.project_id
  region                    = var.region
  external_static_ip_name   = var.external_static_ip_name
}

# Setup Postgres RDBMS 
module "vaultcloud_postgres" {
  source                = "./modules/vaultcloud-sql"
  project_id            = var.project_id
  cloudsql_name         = var.cloudsql_name
  region                = var.region
  db_name               = var.db_name
  db_username           = var.db_username
  db_cluster_zone       = var.db_cluster_zone
  db_schema_bucket      = var.db_schema_bucket
  database_labels       = var.database_labels
  ip_configuration      = { authorized_networks = []
                          ipv4_enabled = false
                          private_network = var.network
                          require_ssl = false}
}

# Deploy vaultcloud Application
module "vaultcloud" {
  source                            = "./modules/vaultcloud"
  project_id                        = var.project_id
  region                            = var.region
  vaultcloud_version                = var.vaultcloud_version
  unseal_keyring_name               = module.unseal_kms.unseal_keyring_name
  unseal_key_name                   = module.unseal_kms.unseal_key_name
  unseal_account_name               = module.unseal_kms.service_account
  num_vaultcloud_pods               = var.num_vaultcloud_pods
  cluster_endpoint                  = module.vaultcloud-gke-cluster.endpoint
  cluster_cert                      = module.vaultcloud-gke-cluster.ca_certificate
  loadbalancer_ip                   = module.vaultcloud_external_ip_address.ip_address
  vaultcloud_tls_k8s_secret         = var.vaultcloud_secret_name
  oidc_secret_name                  = var.oidc_secret_name
  vaultcloud_tls_secret_resource    = module.tls-vaultcloud.secret_resource
  vaultcloud_hostname               = var.vaultcloud_hostname
  db_private_ip_address             = module.vaultcloud_postgres.private_ip_address
  db_password                       = module.vaultcloud_postgres.db_password
  db_username                       = var.db_username
  ui_enabled                        = var.ui_enabled
}

# Provision GCP cloud KMS
module "unseal_kms" {
  source                    = "./modules/vaultcloud-kms"
  project_id                = var.project_id
  region                    = "global"
  keyring_name              = var.keyring_name
  key_name                  = var.key_name
  gcpkms_service_account    = var.gcpkms_service_account
}

# Setup Cloud SQL Auth Proxy
module "vaultcloud_sql_pgproxy" {
  source                  = "./modules/vaultcloud-sql-proxy"
  project_id              = var.project_id
  cloudsql_name           = var.cloudsql_name
  credentials_file        = var.credentials_file
  region                  = var.region
  vaultcloud_namespace    = module.vaultcloud.vaultcloud_namespace
  cluster_endpoint        = module.vaultcloud-gke-cluster.endpoint
  cluster_cert            = module.vaultcloud-gke-cluster.ca_certificate
}

# Setup Ingress service
module "vaultcloud-ingress" {
  source                  = "./modules/vaultcloud-ingress"
  project_id              = var.project_id
  region                  = var.region
  vaultcloud_namespace    = module.vaultcloud.vaultcloud_namespace
  cluster_endpoint        = module.vaultcloud-gke-cluster.endpoint
  cluster_cert            = module.vaultcloud-gke-cluster.ca_certificate
}

# Setup SSL/TLS
module "tls-vaultcloud" {
  source                    = "./modules/vaultcloud-tls"
  vaultcloud_namespace      = module.vaultcloud.vaultcloud_namespace
  vaultcloud_cert           = var.vaultcloud_cert
  vaultcloud_key            = var.vaultcloud_key
  vaultcloud_secret_name    = var.vaultcloud_secret_name
  cluster_endpoint          = module.vaultcloud-gke-cluster.endpoint
  cluster_cert              = module.vaultcloud-gke-cluster.ca_certificate
}

# Setup OIDC secret
module "oidc" {
  source                  = "./modules/vaultcloud-oidc"
  vaultcloud_namespace    = module.vaultcloud.vaultcloud_namespace
  oidc_secret_name        = var.oidc_secret_name
  oidc_service_account    = var.oidc_service_account
  cluster_endpoint        = module.vaultcloud-gke-cluster.endpoint
  cluster_cert            = module.vaultcloud-gke-cluster.ca_certificate
}
