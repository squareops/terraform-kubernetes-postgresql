locals {
  oidc_provider = replace(
    data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer,
    "/^https:///",
    ""
  )
}

data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

resource "random_password" "postgresql_password" {
  count   = var.custom_credentials_enabled ? 0 : 1
  length  = 20
  special = false
}

resource "random_password" "repmgrPassword" {
  count   = var.custom_credentials_enabled ? 0 : 1
  length  = 20
  special = false
}

resource "aws_secretsmanager_secret" "postgresql_user_password" {
  count                   = var.store_password_to_secret_manager ? 1 : 0
  name                    = format("%s/%s/%s", var.environment, var.name, "postgresql")
  recovery_window_in_days = var.recovery_window_aws_secret
}

resource "aws_secretsmanager_secret_version" "postgresql_password" {
  count     = var.store_password_to_secret_manager ? 1 : 0
  secret_id = aws_secretsmanager_secret.postgresql_user_password[0].id
  secret_string = var.custom_credentials_enabled ? jsonencode(
    {
      "posgresql_username" : "postgres",
      "postgres_password" : "${var.custom_credentials_config.postgres_password}",
      "repmgr_username" : "repmgr",
      "repmgr_password" : "${var.custom_credentials_config.repmgr_password}"
    }) : jsonencode(
    {
      "posgresql_username" : "postgres",
      "postgres_password" : "${random_password.postgresql_password[0].result}",
      "repmgr_username" : "repmgr",
      "repmgr_password" : "${random_password.repmgrPassword[0].result}"
  })
}

resource "aws_iam_role" "pgsql_backup_role" {
  name = format("%s-%s-%s", var.cluster_name, var.name, "pgsql-backup")
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_provider}"
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "${local.oidc_provider}:aud" = "sts.amazonaws.com",
            "${local.oidc_provider}:sub" = "system:serviceaccount:${var.namespace}:sa-pgsql-backup"
          }
        }
      }
    ]
  })
  inline_policy {
    name = "AllowS3PutObject"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "s3:GetObject",
            "s3:PutObject",
            "s3:DeleteObject",
            "s3:ListBucket",
            "s3:AbortMultipartUpload",
            "s3:ListMultipartUploadParts"
          ]
          Effect   = "Allow"
          Resource = "*"
        }
      ]
    })
  }
}


resource "aws_iam_role" "pgsql_restore_role" {
  name = format("%s-%s-%s", var.cluster_name, var.name, "pgsql-restore")
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_provider}"
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "${local.oidc_provider}:aud" = "sts.amazonaws.com",
            "${local.oidc_provider}:sub" = "system:serviceaccount:${var.namespace}:sa-postgresql-restore"
          }
        }
      }
    ]
  })
  inline_policy {
    name = "AllowS3PutObject"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "s3:GetObject",
            "s3:PutObject",
            "s3:DeleteObject",
            "s3:ListBucket",
            "s3:AbortMultipartUpload",
            "s3:ListMultipartUploadParts"
          ]
          Effect   = "Allow"
          Resource = "*"
        }
      ]
    })
  }
}
