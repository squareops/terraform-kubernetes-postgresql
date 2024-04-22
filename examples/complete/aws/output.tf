output "posgresql_endpoints" {
  value       = module.postgresql.postgresql_endpoints
  description = "PostgreSQL endpoints in the Kubernetes cluster."
}

output "posgresql_credential" {
  value       = local.store_password_to_secret_manager ? null : module.postgresql.postgresql_credential
  description = "PostgreSQL credentials used for accessing the database."
}
