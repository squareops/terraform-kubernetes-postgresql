variable "cluster_name" {
  default     = ""
  type        = string
  description = "Name of eks cluster"
}

variable "create_namespace" {
  description = "enable/disable functionlaity for namespace"
  type        = bool
  default     = true
}

variable "postgresql_namespace" {
  default     = "postgresql"
  type        = string
  description = "Name of the Kubernetes namespace where the postgresql will be deployed."
}

variable "postgresql_enabled" {
  default     = true
  type        = bool
  description = "Whether or not to deploy postgresql"
}

variable "postgresql_exporter_enabled" {
  default     = false
  type        = bool
  description = "Whether or not to deploy postgresql exporter"
}

variable "recovery_window_aws_secret" {
  type        = number
  default     = 0
  description = "Number of days that AWS Secrets Manager will wait before deleting a secret. This value can be set to 0 to force immediate deletion, or to a value between 7 and 30 days to allow for recovery."
}

variable "chart_version" {
  type        = string
  default     = "11.7.9"
  description = "Version of the Postgresql helm chart that will be deployed."
}

variable "postgresql_config" {
  type = map(string)
  default = {
    name                             = ""
    environment                      = ""
    replicaCount                     = 3
    storage_class                    = "gp2"
    postgresql_values                = ""
    store_password_to_secret_manager = true
  }
  description = "Configuration options for the postgresql such as number of replica,chart version, storage class and store password at secret manager."
}

variable "custom_credentials_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether to enable custom credentials for PostgreSQL database."
}

variable "custom_credentials_config" {
  type = any
  default = {
    postgres_password = ""
    repmgr_password   = ""
  }
  description = "Specify the configuration settings for Postgresql to pass custom credentials during creation."
}
