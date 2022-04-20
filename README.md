
<div align="center">
  <a href="https://example.io">
    <img width="500" src="logo/vaultcloud.png" >
  </a>

<p align="center">
  <br>
  secure, store and tightly control access to tokens, passwords, certificates and other sensitive data across multiple applications and tools.
  <br>
  <a href="https://example.com/drive/folders/"><strong>Explore VaultCloud docs »</strong></a>
  <br>
  <br>
  <a href="mailto:vaultcloud@example.com">Report bug</a>
  ·
  <a href="mailto:webmaster@example.com">Request feature</a>
  ·
  <a href="mailto:webmaster@example.com">Support</a>
  <br>
</p>
</div>

## Table of content

  - [Introduction.](#introduction)
  - [Development](#development)
  - [Feature Highlights](#feature-highlights)
  - [Bugs and feature requests](#bugs-and-feature-requests)
  - [Documentation](#documentation)
  - [Contributing](#contributing)
  - [Copyright and license](#copyright-and-license)


## Introduction

The Vault controls all aspects of sensitive information. A tool that secures, stores, and tightly controls access to tokens, passwords, certificates, API keys, and other secrets in modern computing environments. Secret management service can handle leasing, key revocation, key rolling and auditing. Through a unified API, users can access an encrypted Key/Value store and network encryption-as-a-service, or generate system credentials, SQL/NoSQL databases, SSL/TLS certificates, SSH key pair and more.

## Development

This codebase follows the best coding practices, highly structured and modular in nature, that way the project can easily be scaled without having to unpick it if you decide to restructure. Each module is really just a folder, just does one specific job which is fully independent from other modules and functionalities. Modules that hold config files that are coded in such a way that the code can be re-used. 

Highly-available Vault cluster can be provisioned on Google Kubernetes Engine using Hashicorp Terraform as the provision tool with One-Click.

## Feature Highlights

- **High Availability** - The Vault cluster is deployed in HA mode on GKE backed by Google Cloud SQL

- **Production Hardened** - VaultCloud is deployed according to the best production hardening practices.

- **High Throughput** - Due to the replication technology, Vault is very scalable in GKE and can provide a high throughput rates to meet most needs.

- **Secret Storage** - Vault supports many types of storage backends where encrypted data is persisted. This architecture is implemented with Cloud SQL Postgres, Reason for choosing Cloud SQL Postgres is that it is a fully managed service by Google Cloud, so no maintenance overhead. Postgresql is best for writing. Its performance is many times higher in Read/Write operations as compared to Consul and Cloud Storage in Vault benchmark testing.

- **Cloud SQL Auth Proxy** - Cloud SQL Auth Proxy to enable secure connection between GKE Vault pods to Cloud SQL Postgres database. Which provides secure access to instances without the need for Authorized Networks.

- **Auto-Init and Unseal** - VaultCloud is automatically initialized and unsealed
  at runtime. The unseal keys are encrypted with [Google Cloud KMS](https://cloud.google.com/security-key-management)

- **Load Balancer** - We Kubernetes NGINX Ingress controller and configure SSL passthrough in the ingress controller to be able to do End-To-End TLS authentication. Using NGINX Ingress on your Kubernetes cluster it is possible to restrict access to your application based on dedicated IP addresses or CIDR range.

- **Full Isolation** - The VaultCloud cluster is provisioned in its own Kubernetes
  cluster in a dedicated GCP project. Clients connect to VaultCloud using **only** the load balancer and VaultCloud
  is treated as a managed external service restricted to only to your organization network.

- **Audit Logging** - Audit logging to can be enabled using preferred monitoring solution. It is important to gain operational and usage metrics of running VaultCloud for the purposes of understanding system performance, usage, auditing and taking proactive measures to prevent security incidents.

## Vault Application Configuration:
Some of the Vault configurations are important to consider and aware of. 
 - Enable StatefulSet to Vault. Which manages Pods that are based on the identical container spec. Provides guarantees about ordering and uniqueness of the Pods. Also provides predictable naming and stable networking identifiers.
- Enable Anti-Affinity Rules: It ensures the desired number of Pods in a host. Each Vault server should run on a unique host. This provides added availability in case one node goes down.
- Enable readinessProbe: Which ensures the standby servers are healthy and available to replace the active node  if it goes offline. Probes are essential for detecting failures, rescheduling and using Pods.
- UI: We can disable UI for production deployment as the request/response happens over API calls. If we need to enable UI, make sure to restrict only for required IP/CIDR ranges.

## Backup:
Database Backup:
- High availability cluster is configured to maintain multiple replicas.
- Data is backed up daily, weekly and monthly to multiple regions.
- Only metadata is stored and actual data configured to be stored in their own specific data stores.

## Security:
Vault is deployed according to the best production hardening practices. With a fully isolated environment, least privileges access and cluster is provisioned in its own Kubernetes cluster in a dedicated GCP project. Clients connect to Vault using only the load balancer and Vault is treated as a managed external service restricted to only the ALLOWED network.

## Bugs and feature requests

Have a bug or a feature request? please leave a comment here - https://bit.ly/3vvygYW

## Documentation

Full, comprehensive documentation is available on the [VaultCloud Docs](https://github.com/raviboodher/vaultcloud/tree/master/docs).


## Copyright and license

Mozilla Public License, version 2.0





