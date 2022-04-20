resource "helm_release" "vaultcloud" {
  name       = var.helm_release_name
  repository = var.helm_repository
  chart      = var.helm_chart_name
  namespace  = kubernetes_namespace.vaultcloud.metadata.0.name

  values = [<<EOF
global:
  tlsDisable: false
server:
  image:
    repository: "vault"
    tag: "${var.vaultcloud_version}"

  updateStrategyType: "RollingUpdate"
  agentImage:
    repository: "vault"
    tag: "${var.vaultcloud_version}"
  extraEnvironmentVars:
    VAULT_ADDR: https://127.0.0.1:8200
    VAULT_SKIP_VERIFY: true
    VAULT_API_ADDR: https://127.0.0.1
  extraVolumes:
    - type: secret
      name: ${var.vaultcloud_tls_k8s_secret}
    - type: secret
      name: ${var.oidc_secret_name}

  # Enables a headless service to be used by the Vault Statefulset
  # service:
  #   enabled: true
  #   # clusterIP: None
  #   type: "NodePort"

  ingress:
    enabled: true
    annotations:
      kubernetes.io/ingress.class: "nginx"
      kubernetes.io/ingress.allow-http: "false"
      nginx.ingress.kubernetes.io/backend-protocol: HTTPS
      nginx.ingress.kubernetes.io/ssl-passthrough: "true"
      nginx.ingress.kubernetes.io/ssl-redirect: "true"
    hosts:
      - host: ${var.vaultcloud_hostname}
    tls:
      - secretName: ${var.vaultcloud_tls_k8s_secret}
        hosts:
          - ${var.vaultcloud_hostname}
  ha:
    enabled: true
    replicas: ${var.num_vaultcloud_pods}

    sapiAddr: null
    
    config: |
      ui = ${var.ui_enabled}

      log_level = "info"

      listener "tcp" {
        tls_disable = 0
        address = "[::]:8200"
        cluster_address = "[::]:8201"
        tls_cert_file = "/vault/userconfig/${var.vaultcloud_tls_k8s_secret}/vaultcloud-io.cert"
        tls_key_file  = "/vault/userconfig/${var.vaultcloud_tls_k8s_secret}/vaultcloud-io.key"
        telemetry {
          unauthenticated_metrics_access = true
        }
      }

      storage "postgresql" {
        connection_url = "postgres://${var.db_username}:${var.db_password}@pg-sqlproxy-gcloud-sqlproxy:5432/vaultcloud-db?sslmode=disable"
        table="vault_kv_store",
        ha_enabled=true,
        ha_table="vault_ha_locks" 
      } 

      seal "gcpckms" {
        project     = "${var.project_id}"
        region      = "global"
        key_ring    = "${var.unseal_keyring_name}"
        crypto_key  = "${var.unseal_key_name}"
      }
      
      telemetry {
        prometheus_retention_time = "30s",
        disable_hostname = true
      }

      api_addr     = "[::]:8200"
      cluster_addr = "[::]:8201"
      service_registration "kubernetes" {}

ui:
  enabled: ${var.ui_enabled}
  serviceType: "LoadBalancer"
  serviceNodePort: null
  externalPort: 8200
  loadBalancerIP: ${var.loadbalancer_ip}
  
EOF
  ]

  depends_on = [
    var.vaultcloud_tls_secret_resource, var.db_private_ip_address, kubernetes_namespace.vaultcloud
  ]
}
