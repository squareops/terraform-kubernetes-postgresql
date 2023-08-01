locals {
  name        = "postgresql"
  region      = "us-east-2"
  environment = "prod"
  additional_tags = {
    Owner      = "organization_name"
    Expires    = "Never"
    Department = "Engineering"
  }
}

module "postgresql" {
  source               = "https://github.com/sq-ia/terraform-kubernetes-postgresql.git"
  cluster_name         = "dev-skaf"
  postgresql_exporter_enabled = true
  postgresql_config = {
    replicaCount               = 3
    postgresql_sc              = "gp2"
    postgresql_values          = file("./helm/postgresql.yaml")
  }
}