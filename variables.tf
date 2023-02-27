variable "project_prefix" {
  type        = string
  default     = "f5xc"
}

variable "owner_tag" {
  type        = string
  default     = "user@email"
}

variable "f5xc_api_p12_file" {
  type = string
}

variable "f5xc_api_url" {
  type = string
}

variable "f5xc_api_ca_cert" {
  type = string
  default = ""
}

variable "f5xc_api_token" {
  type = string
}

variable "f5xc_tenant" {
  type = string
}

variable "f5xc_namespace" {
  type    = string
  default = "system"
}

variable "f5xc_reg_url" {
  type = string
  default = "ves.volterra.io"
}

variable "pm_api_url" {}
variable "pm_api_token_id" {}
variable "pm_api_token_secret" {}
variable "pve_host" {}
variable "pve_user" {}
variable "pve_password" {}

variable "admin_password" {
  type = string
  default = ""
}
