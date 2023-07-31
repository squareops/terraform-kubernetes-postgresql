locals {
  region           = "us-east-2"
  environment      = "dev"
  name             = "skaf"
  current_identity = data.aws_caller_identity.current.arn
  additional_tags = {
    Owner      = "SquareOps"
    Expires    = "Never"
    Department = "Engineering"
  }
}

data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

resource "random_password" "postgresql_password" {
  length  = 20
  special = false
}

resource "random_password" "repmgrPassword" {
  length  = 20
  special = false
}

resource "kubernetes_namespace" "postgresql" {
  metadata {
    name = var.postgresql_namespace
  }
}


resource "helm_release" "postgresql_ha" {
  count      = var.postgresql_enabled   ? 1 : 0
  depends_on = [kubernetes_namespace.postgresql]
  name       = "postgresql-ha"
  chart      = "postgresql-ha"
  version    = var.postgresql_config.chart_version
  namespace  = var.postgresql_namespace
  repository = "https://charts.bitnami.com/bitnami"
  timeout    = 600
  values = [
    templatefile("${path.module}/helm/postgresql/values.yaml", {
      replicaCount        = var.postgresql_config.replicaCount,
      postgresql_sc       = var.postgresql_config.postgresql_sc,
      repmgrPassword      = random_password.repmgrPassword.result,
      postgresql_password = random_password.postgresql_password.result
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
      postgresql_password = random_password.postgresql_password.result,
      namespace           = var.postgresql_namespace
    }),
    var.postgresql_config.postgresql_exporter_values
  ]
}
