# Variables with default values or values specified in an {env}.tfvars file

variable "location" {
  default = "UK South"
}

variable "common_tags" {
  type = map(string)
}

# Database

variable "db_storage_mb" {
  default = "5120"
}

variable "component" {
  default = "service"
}

variable "db_version" {
  default = 11
}

variable "db_postgresql_user" {
  default = "employment_tribunals_postgresql_user"
}

# Keyvault

variable "product_group_name" {
  default = "dcd_group_pet_v2"
}
