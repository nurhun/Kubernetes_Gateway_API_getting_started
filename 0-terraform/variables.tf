# --- root/variables.tf ---

variable "REGION" {
  type = string
  description = "GCP region"
}

variable "PROJECT_ID" {
  type = string
  description = "GCP project name"
}

variable "ZONE" {
  type        = string
  description = "GCP project zone"
}

variable "CLUSTER_NAME" {
  type        = string
  description = "GKE cluster name"
}



variable "services" {
  type        = list(any)
  description = "List of required services to be enabled."
  default = [
    "cloudresourcemanager.googleapis.com",
    "container.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "cloudtrace.googleapis.com",
    "servicenetworking.googleapis.com",
    "networkconnectivity.googleapis.com",
  ]
}
