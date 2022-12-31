# --- gke/nodepools.tf ---

resource "google_container_node_pool" "main-pool" {
  depends_on = [google_container_cluster.cluster]

  name    = "main-pool"
  project = var.PROJECT_ID
  cluster = google_container_cluster.cluster.name
  version = var.main_pool_version

  # node_count         = "1"
  node_locations     = [var.ZONE]
  initial_node_count = "0"
  location           = var.ZONE
  max_pods_per_node  = "110"

  autoscaling {
    max_node_count = "2"
    min_node_count = "1"
  }

  management {
    auto_repair  = "true"
    auto_upgrade = "true"
  }

  node_config {
    disk_size_gb    = "100"
    disk_type       = "pd-standard"
    image_type      = "COS_CONTAINERD"
    local_ssd_count = "0"
    machine_type    = var.preemptible_instance_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    preemptible     = var.preemptible
    service_account = "default"

    shielded_instance_config {
      enable_integrity_monitoring = "true"
      enable_secure_boot          = "false"
    }

    labels = {
      environment = "demo"
      role        = "compute"
      project     = var.PROJECT_ID
    }

  }


  upgrade_settings {
    max_surge       = "1"
    max_unavailable = "0"
  }

  lifecycle {
    ignore_changes = [
      initial_node_count
    ]
  }
}