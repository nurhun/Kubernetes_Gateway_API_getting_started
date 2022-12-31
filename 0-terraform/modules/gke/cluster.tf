# --- gke/cluster.tf ---


resource "google_container_cluster" "cluster" {

  name     = var.CLUSTER_NAME
  location = var.ZONE
  project  = var.PROJECT_ID

  initial_node_count       = "1"
  remove_default_node_pool = true

  binary_authorization {
    evaluation_mode = "DISABLED"
  }
    enable_intranode_visibility = "false"
  enable_kubernetes_alpha     = "false"
  enable_legacy_abac          = "false"
  enable_shielded_nodes       = "true"
  enable_tpu                  = "false"

  datapath_provider         = "LEGACY_DATAPATH"
  default_max_pods_per_node = "110"

  release_channel {
    # channel = "UNSPECIFIED"
    channel = var.master_release_channel
  }

  addons_config {
    horizontal_pod_autoscaling {
      disabled = "false"
    }

    http_load_balancing {
      disabled = "false"
    }

    network_policy_config {
      disabled = "true"
    }
  }

  vertical_pod_autoscaling {
    enabled = "true"
  }

  cluster_autoscaling {
    enabled = "false"
  }

  database_encryption {
    state = "DECRYPTED"
  }

  default_snat_status {
    disabled = "false"
  }

  network_policy {
    enabled  = "false"
    provider = "PROVIDER_UNSPECIFIED"
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.60.0.0/14"
    services_ipv4_cidr_block = "10.64.0.0/20"
  }

  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
  }


  master_auth {
    client_certificate_config {
      issue_client_certificate = "false"
    }
  }

  networking_mode = "VPC_NATIVE"
  network         = var.cluster_network
  subnetwork      = var.cluster_subnet

  private_cluster_config {
    enable_private_endpoint = "false"
    enable_private_nodes    = "true"

    master_global_access_config {
      enabled = "false"
    }

    master_ipv4_cidr_block = "172.16.0.0/28"
  }

  maintenance_policy {
    recurring_window {
      recurrence = "FREQ=WEEKLY;BYDAY=MO"
      start_time = "2022-12-13T11:00:00Z"
      end_time   = "2022-12-14T11:00:00Z"
    }
  }

  gateway_api_config {
    channel = var.gateway_api_config_channel
  }

  lifecycle {
    create_before_destroy = true
  }

}