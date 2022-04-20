# Create keyring for unseal key
resource "google_kms_key_ring" "vaultcloud_key_ring" {
  project  = var.project_id
  name     = var.keyring_name
  location = var.keyring_location
}

# Create key to unseal vaultcloud
resource "google_kms_crypto_key" "vaultcloud_crypto_key" {
  name            = var.key_name
  key_ring        = google_kms_key_ring.vaultcloud_key_ring.self_link
  rotation_period = "100000s"
}

# Create Service Account for vaultcloud to fetch unseal keys
resource "google_service_account" "vaultcloud_kms_service_account" {
  account_id   = var.gcpkms_service_account
  display_name = "vaultcloud KMS for auto-unseal"
  project      = var.project_id
}


# Add the service account to the Keyring
resource "google_kms_key_ring_iam_binding" "vaultcloud_iam_kms_binding" {
  key_ring_id = google_kms_key_ring.vaultcloud_key_ring.id
  role        = "roles/owner"

  members = [
    "serviceAccount:${google_service_account.vaultcloud_kms_service_account.email}",
  ]
}

# Grant service account access to the key
resource "google_project_iam_member" "service-account-iam-memberships" {
  count   = length(var.service_account_iam_roles)
  project = var.project_id
  role    = element(var.service_account_iam_roles, count.index)
  member  = "serviceAccount:${google_service_account.vaultcloud_kms_service_account.email}"
}

resource "google_kms_crypto_key_iam_member" "service-account-encrypter-decrypter" {
  crypto_key_id = google_kms_crypto_key.vaultcloud_crypto_key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${google_service_account.vaultcloud_kms_service_account.email}"
}
