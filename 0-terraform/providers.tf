# --- providers.tf ---

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">4.46.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">4.5.0"
    }
  }
}


provider "google" {
  project = var.PROJECT_ID
  region  = var.REGION
  credentials = "auth/terraform_sa.json"
}


provider "google-beta" {
  project = var.PROJECT_ID
  region  = var.REGION
  credentials = "auth/terraform_sa.json"
}
