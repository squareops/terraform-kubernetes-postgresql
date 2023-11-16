variable "cluster_name" {
  description = "The name of the AWS EKS cluster."
}

variable "custom_credentials_enabled" {
  description = "Set to true if you want to use custom credentials, false to generate random passwords."
  default     = false
  type        = string
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "The name of the environment for resource naming."
}

variable "name" {
  type        = string
  default     = ""
  description = "A name or identifier for resources."
}

variable "recovery_window_aws_secret" {
  type        = number
  default     = 0
  description = "The recovery window (in days) for an AWS Secrets Manager secret."
}

variable "custom_credentials_config" {
  description = "Custom credentials configuration."
  default = {
    postgres_password = ""
    repmgr_password   = ""
  }
}

variable "store_password_to_secret_manager" {
  description = "Store the password to sceret manager"
  type        = bool
  default     = false
}

variable "postgresql_config" {
  description = "Custom credentials configuration."
  default = {
    name                             = ""
    environment                      = ""
    replicaCount                     = 3
    storage_class                    = "gp2"
    postgresql_values                = ""
    store_password_to_secret_manager = true
  }
}
