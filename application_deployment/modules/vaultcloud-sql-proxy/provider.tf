provider "kubernetes" {
  host  = var.cluster_endpoint
  token = data.google_client_config.current.access_token

  cluster_ca_certificate = base64decode(
    var.cluster_cert,
  )
}

provider "helm" {
  kubernetes {
    host  = var.cluster_endpoint
    token = data.google_client_config.current.access_token

    cluster_ca_certificate = base64decode(
      var.cluster_cert,
    )
  }
}
