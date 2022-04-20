output "token_accessor" {
  description = "When tokens are created, a token accessor is also created and returned. This accessor is a value that acts as a reference to a token"
  value       = vault_jwt_auth_backend.gsuite.accessor
}