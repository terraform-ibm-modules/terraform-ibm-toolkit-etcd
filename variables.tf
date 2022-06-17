
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group for the etc database"
}

variable "region" {
  type        = string
  description = "The region where the etcd database will be provisioned"
}

variable "name_prefix" {
  type        = string
  description = "The prefix name for the service. If not provided it will default to the resource group name"
  default     = ""
}

variable "plan" {
  type        = string
  description = "The type of plan the service instance should run under (standard)"
  default     = "standard"
}

variable "provision" {
  type        = bool
  description = "Flag indicating that cos instance should be provisioned"
  default     = true
}

variable "name" {
  type        = string
  description = "The name that should be used for the service, particularly when connecting to an existing service. If not provided then the name will be defaulted to {name prefix}-{service}"
  default     = ""
}

variable "label" {
  type        = string
  description = "The name that should be used for the service, particularly when connecting to an existing service. If not provided then the name will be defaulted to {name prefix}-{service}"
  default     = "etcd"
}

variable "key_protect_instance" {
  type        = string
  description = "The id of the key protect instance"
  default     = null
}

variable "key_protect_key" {
  type        = string
  description = "The id of the key that will be used to encrypt the database"
  default     = null
}

variable "backup_key_protect_key" {
  type        = string
  description = "The id of the key that will be used to encrypt the database backup"
  default     = null
}

variable "tags" {
  type        = list(string)
  description = "The tags that should be added to the resource"
  default     = []
}

variable "disable_public_endpoints" {
  type        = bool
  description = "Flag indicating that public endpoints should be disabled"
  default     = false
}

variable "database_version" {
  type        = string
  description = "The version of the database to provision"
  default     = "3.4"
}

variable "memory_allocation" {
  type        = number
  description = "Memory allocation in MB for the cluster"
  default     = 30720
}

variable "disk_allocation" {
  type        = number
  description = "Disk allocation in MB for the cluster"
  default     = 768000
}

variable "cpu_allocation" {
  type        = number
  description = "Number of CPUs to allocate for the cluster"
  default     = 9
}

variable "backup_etcd_crn" {
  type        = string
  description = "The crn of the etcd database that will be used for backups"
  default     = null
}

variable "remote_leader_etcd_crn" {
  type        = string
  description = "The crn of the etcd database that will be used for the remote leader"
  default     = null
}
