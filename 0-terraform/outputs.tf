# --- root/outputs.tf ---

output "project" {
  value = data.google_client_config.project_config.project
}

output "vpc_id" {
  value = module.networking.vpc_id
}

output "subnets" {
  value = module.networking.subnets
}