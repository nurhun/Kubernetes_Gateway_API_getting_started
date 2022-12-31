# --- root/main.tf ---

data "google_project" "project" {
}

data "google_client_config" "project_config" {
}

data "google_container_engine_versions" "central1-a" {
  provider = google-beta
  location = "us-central1-a"
  version_prefix = "1.24."
}

resource "google_project_service" "enabled_services" {
  for_each = toset(var.services)
  service  = each.key
  provisioner "local-exec" {
    command = "sleep 60"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "sleep 15"
  }

  disable_on_destroy = false

}


# module "networking" {
#   source                              = "./modules/networking"
  
#   REGION                              = var.REGION
#   PROJECT_ID                          = var.PROJECT_ID
#   vpc_name                            = "demo-vpc"
#   vpc_description                     = "Demo VPC."
#   vpc_auto_create_subnetworks         = false
#   vpc_delete_default_routes_on_create = false
#   vpc_mtu                             = 1460
#   vpc_routing_mode                    = "REGIONAL"

#   ## Router ###
#   router_name = "vpc-router"

#   ### Cloud NAT ###
#   cloud_nat_name                     = "vpc-nat"
#   nat_ip_allocate_option             = "AUTO_ONLY"
#   source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
#   nat_log_enabled                    = true

# }


# module "gke" {
#   source                              = "./modules/gke"
  
#   REGION                              = var.REGION
#   ZONE                                = var.ZONE
#   PROJECT_ID                          = var.PROJECT_ID
#   CLUSTER_NAME                        = var.CLUSTER_NAME
#   master_release_channel              = "REGULAR"       # currently v1.24.7-gke.900 as GKE Gateway is not supported on cluster versions < 1.24.0.
#   gateway_api_config_channel          = "CHANNEL_STANDARD"
#   cluster_network                     = module.networking.vpc_id
#   cluster_subnet                      = module.networking.subnets["us-central1"]
#   preemptible                         = true
#   preemptible_instance_type           = "n2d-standard-2"
#   main_pool_version                   = data.google_container_engine_versions.central1-a.release_channel_default_version["REGULAR"]
# }