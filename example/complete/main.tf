locals {
  region      = "us-east-2"
  environment = "dev"
  name        = "skaf"
  additional_tags = {
    Owner      = "SquareOps"
    Expires    = "Never"
    Department = "Engineering"
  }
}

module "postgresql" {
  source               = "https://github.com/sq-ia/terraform-kubernetes-postgresql.git"
  cluster_name         = "dev-skaf"
  postgresql_namespace = "postgresql"
  postgresql_enabled   = true
  postgresql_config = {
    replicaCount               = 3
    chart_version              = "11.7.9"
    postgresql_sc              = "gp2"
    postgresql_values          = file("./helm/postgresql.yaml")
    postgresql_exporter_values = file("./helm/postgresql_exporter.yaml")
  }
}