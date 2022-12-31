# --- networking/main.tf ---

resource "google_compute_network" "vpc" {
  project                         = var.PROJECT_ID
  name                            = var.vpc_name
  description                     = var.vpc_description
  auto_create_subnetworks         = var.vpc_auto_create_subnetworks
  delete_default_routes_on_create = var.vpc_delete_default_routes_on_create
  mtu                             = var.vpc_mtu
  routing_mode                    = var.vpc_routing_mode

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_subnetwork" "subnets" {
  project = var.PROJECT_ID
  network = google_compute_network.vpc.self_link

  for_each = var.subnets

  name                     = each.key
  region                   = each.key
  ip_cidr_range            = each.value.ip_cidr_range
  private_ip_google_access = each.value.private_ip_google_access
  # private_ipv6_google_access = each.value.private_ipv6_google_access
  stack_type = each.value.stack_type
}

resource "google_compute_router" "central1-router" {
  name    = var.router_name
  description = "vpc-router"
  network = google_compute_network.vpc.id
  region  = google_compute_subnetwork.subnets["${var.REGION}"].region
}


resource "google_compute_router_nat" "cloud-nat" {
  name                               = var.cloud_nat_name
  router                             = google_compute_router.central1-router.name
  region                             = google_compute_router.central1-router.region
  nat_ip_allocate_option             = var.nat_ip_allocate_option
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat
  enable_endpoint_independent_mapping= "false"
  min_ports_per_vm = "64"

  log_config {
    enable = var.nat_log_enabled
    filter = "ALL"
  }
}