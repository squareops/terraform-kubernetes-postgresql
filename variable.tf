variable "cluster_name" {
  default     = ""
  type        = string
  description = "Name of eks cluster"
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

variable "postgresql_config" {
  type = any
  default = {
    name                       = ""
    environment                = ""
    replicaCount               = 3
    chart_version              = "11.7.9"
    postgresql_sc              = "gp2"
    postgresql_values          = ""
    postgresql_exporter_values = ""
  }
  description = "Configuration options for the postgresql such as number of replica,chart version and storage class."
}
