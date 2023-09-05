resource "kubernetes_namespace" "postgresql" {
  count = var.postgresql_enabled ? 1 : 0
  metadata {
    name = var.postgresql_namespace
  }
}

resource "helm_release" "postgresql_ha" {
  count      = var.postgresql_enabled ? 1 : 0
  depends_on = [kubernetes_namespace.postgresql]
  name       = "postgresql-ha"
  chart      = "postgresql-ha"
  version    = var.chart_version
  namespace  = var.postgresql_namespace
  repository = "https://charts.bitnami.com/bitnami"
  timeout    = 600
  values = [
    templatefile("${path.module}/helm/postgresql/values.yaml", {
      replicaCount              = var.postgresql_config.replicaCount,
      storage_class             = var.postgresql_config.storage_class,
      repmgrPassword            = var.custom_credentials_enabled ? var.custom_credentials_config.repmgr_password : var.repmgr_password,
      postgresql_password       = var.custom_credentials_enabled ? var.custom_credentials_config.postgres_password : var.postgres_password
      service_monitor_namespace = var.postgresql_namespace
    }),
    var.postgresql_config.postgresql_values
  ]
}

resource "helm_release" "postgres_exporter" {
  count      = var.postgresql_enabled && var.postgresql_exporter_enabled ? 1 : 0
  depends_on = [helm_release.postgresql_ha]
  name       = "postgres-exporter"
  chart      = "prometheus-postgres-exporter"
  version    = "4.8.0"
  timeout    = 600
  namespace  = var.postgresql_namespace
  repository = "https://prometheus-community.github.io/helm-charts"
  values = [
    templatefile("${path.module}/helm/postgresql_exporter/values.yaml", {
      namespace           = var.postgresql_namespace,
      postgresql_password = var.custom_credentials_enabled ? var.custom_credentials_config.postgres_password : var.postgres_password
    })
  ]
}
