# Vault Cloud Deployment


----

This document walks through provisioning a highly-available VaultCloud cluster on Google Kubernetes Engine using HashiCorp Terraform as the provisioning tool. Core application behind VaultCloud is Hashicorp's Vault. Official documentation of implementing Vault on kubernetes is really good, but there are many pieces missing to run as an enterprise grade application. 

In VaultCloud, many features are added on top of Hashicorp's Vault core to make it fully functional feature rich enterprise application such as Auto Unseal using Google Cloud KMS, NGINX as an Ingress to control access, Single Sign On using GSuite, Cloud SQL as backend datastore etc.

Everything is modularised with terraform to produce VaultCloud Kubernetes cluster on GKE with minimal pain. This document explains basic inputs required to provision VaultCloud on GCP.

----

## Prerequisites

* Terraform v1 or later

## Credentials

As with all Terraform on GCP, you'll need to have a service account and provide this module with access to it. That service account will need quite a few permissions, as it will be creating a static external IP, making new service accounts for vaultcloud, generating Kubernetes secrets, setting up a cluster, generating keys and keyrings in Cloud KMS, and more. The JSON key for these credentials should be stored somewhere that Terraform can access it, but do not commit these credentials to a repo in plaintext.

## DNS

Once cluster is UP, you will need to grab the IP address of the cluster and update DNS records. Terraform will output external static IP Address.

## Configuration

These parameters are required to be updated in terraform tfvars file. 

- `project_id`  - GCP Project ID where application needs to provisioned.
- `credentials_file` - GCP Service Account credentials file absolute path.
- `region` - Google Cloud region in which application needs to be provisioned.
- `cluster_zone` - Google Cloud Zone in which application needs to be provisioned.
- `network` - GCP VPC Network in which GCP resources will be created.
- `subnetwork` - Subnetwork name in which GCP resources will be created.
- `node_count` - Number of node pool in which VaultCloud application needs to deployed.
- `num_vaultcloud_pods` - Number of VaultCloud pods to create in GKE cluster.
- `cluster_name` - Name of the GKE cluster. Terraform provisions new GKE cluster, so make sure to provide unique name.
- `vaultcloud` - Version, which is Hashicorp Vault core version, get it from Hashicorp Official website.
- `vaultcloud_hostname` - Domain name of the VaultCloud.
- `cloudsql_name` - GCP Cloud SQL cluster name, it should be unique.
- `db_name` - Database name of the VaultCloud.
- `db_username` - Database username.
- `cluster_ipv4_cidr_block` - The IP address range for the cluster pod IPs.
- `services_ipv4_cidr_block` - The IP address range of the services IPs.
- `db_user_labels` - Database labels in dictionary format. ex. { "name" : "vaultcloud" } 
- `gcpkms_service_account` - name for service sccount for VaultCloud to fetch unseal keys.
- `keyring_name` - GCP KMS keyring name.
- `key_name` - GCP Cloud KMS key name.
- `external_static_ip_name` - Name to assign for External Static IP.
- `vaultcloud_key` - VaultCloud TLS key.
- `vaultcloud_cert` -  VaultCloud cert.
- `vaultcloud_secret_name` - Name to use for the k8s secret containing the TLS cert/key.
- `oidc_secret_name` - OIDC secret name to mount on the pod.
- `oidc_service_account` - OIDC service account name.

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

4. Once after `terraform apply` is succeeded, make sure cluster is fully provisioned by visiting GCP console. Then connect the cluster using the `gcloud` command. 
   
   ```
   $ gcloud container clusters get-credentials <cluster name> --region <region name> --project <project name>
   ```

5. Initialize and generate ROOT token.
   
   ```
   kubectl exec -ti vault-0 -n vaultcloud -- vault operator init 
   ```
6. Update DNS records
   
   Terraform will output IP address of the cluster, an A record is required to link desired sub-domain to the public ip address.

## Things to Keep in Mind
When we run `terraform apply` to deploy fresh GKE cluster, GCP takes time to provision kubernetes cluster and associatated services, in case if you see an error in the terraform output to verify using `helm` command, visit Google Cloud console and check if the cluster provision is completed, if not, wait for it to complete. Then follow step 4 and 5 of deployment section and then run `terraform apply` again.

## Need help? 

Please connect with developers at vaultcloud@example.com
