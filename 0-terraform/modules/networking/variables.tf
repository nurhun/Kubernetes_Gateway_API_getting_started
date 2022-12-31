# -- networking/variables.tf

variable "REGION" {}

### VPC test-vpc ###
variable "PROJECT_ID" {}
variable "vpc_name" {}
variable "vpc_description" {}
variable "vpc_auto_create_subnetworks" {}
variable "vpc_delete_default_routes_on_create" {}
variable "vpc_mtu" {}
variable "vpc_routing_mode" {}


### Subnet subnets ###
variable "subnets" {
  description = "demo-vpc subnets"
  type        = map(any)
  default = {
    "us-central1" = {
      ip_cidr_range              = "10.128.0.0/20",
      private_ip_google_access   = "true",
      # private_ipv6_google_access = "true",
      stack_type                 = "IPV4_ONLY",
    }
  }
}

## Router ###
variable "router_name" {}


### Cloud NAT ###
variable "cloud_nat_name" {}
variable "nat_ip_allocate_option" {}
variable "source_subnetwork_ip_ranges_to_nat" {}
variable "nat_log_enabled" {}

