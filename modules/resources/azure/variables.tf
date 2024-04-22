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

variable "postgresql_config" {
  description = "Configuration options for PostgreSQL."
  default = {
    store_password_to_secret_manager = false
  }
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

variable "resource_group_name" {
  description = "Resource group name"
  default     = ""
  type        = string
}

variable "resource_group_location" {
  description = "Resource group location"
  default     = "eastus"
  type        = string
}
