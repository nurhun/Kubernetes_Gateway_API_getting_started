# --- networking/outputs.tf ---

output "vpc_id" {
  value = google_compute_network.vpc.id
}

output "subnets" {
  value = {
    for k, subnet in google_compute_subnetwork.subnets : k => subnet.id
  }
}