# --- backends.tf ---

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}