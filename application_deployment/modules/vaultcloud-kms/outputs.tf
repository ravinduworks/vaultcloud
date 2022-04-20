output "unseal_keyring_name" {
  value = google_kms_key_ring.vaultcloud_key_ring.name
}

output "unseal_key_name" {
  value = google_kms_crypto_key.vaultcloud_crypto_key.name
}

output "service_account" {
  value = google_service_account.vaultcloud_kms_service_account.email
}
