# --- gke/variables.tf ---

variable "REGION" {}
variable "ZONE" {}
variable "PROJECT_ID" {}

variable "CLUSTER_NAME" {}

variable "cluster_network" {}
variable "cluster_subnet" {}

variable "master_release_channel" {
  type = string
  description = "Release channel for automatic upgrades of GKE clusters. Could be UNSPECIFIED, RAPID, REGULAR or STABLE"
  default = "STABLE"
}

variable "gateway_api_config_channel" {
  type = string
  description = "Which Gateway Api channel should be used. CHANNEL_DISABLED or CHANNEL_STANDARD."
  default = "CHANNEL_STANDARD"
}

variable "main_pool_version" {
  type = string
  description = "main_pool nodes version"
}

variable "preemptible" {
  type = bool
  default = false  
}

variable "preemptible_instance_type" {
  default = "n2d-standard-2"
}