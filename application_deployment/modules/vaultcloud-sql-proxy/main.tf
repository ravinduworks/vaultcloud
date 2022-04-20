resource "helm_release" "proxy" {
  name       = var.helm_release_name
  chart      = var.helm_chart
  version    = var.helm_chart_version
  namespace  = var.vaultcloud_namespace

  values = [<<EOF

  serviceAccountKey: ${filebase64(var.credentials_file)}

  cloudsql:
    ## PostgreSQL/MySQL instances:
    ## update with your GCP project, the region of your Cloud SQL instance
    ## and the name of your Cloud SQL instance
    ## PostgreSQL port 5432 or MySQL port 3306, or other port you set for your SQL instance.
    ## Use different ports for different instances.

    instances:
      # GCP instance name.
    - instance: ${var.cloudsql_name}
      # Optional abbreviation used to override the truncated instance name if the
      # 15 character instance name prefix is not unique for use as a port
      # identifier.
      instanceShortName: ""
      # GCP project where the instance exists.
      project: ${var.project_id}
      # GCP region where the instance exists.
      region: ${var.region}
      # Port number for the proxy to expose for this instance.
      port: 5432
EOF
  ]
}