output "posgresql" {
  description = "Postgresql_Info"
  value = {
    postgresql_port               = "5432",
    postgresql_ha_pgpool_endpoint = "postgresql-ha-pgpool.${var.postgresql_namespace}.svc.cluster.local",
    postgresql_primary_endpoint   = "postgresql-ha-postgresql.${var.postgresql_namespace}.svc.cluster.local",
    postgresql_headless_endpoint  = "postgresql-ha-postgresql-headlesss.${var.postgresql_namespace}.svc.cluster.local",
    postgresql_metrics_endpoint   = "postgresql-ha-postgresql-metrics.${var.postgresql_namespace}.svc.cluster.local"
  }
}