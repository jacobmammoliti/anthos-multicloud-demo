resource "google_service_account" "gke_service_account" {
  project      = module.project.project_id
  account_id   = "gke-tenant"
  display_name = "GKE Tenant Service Account"
}

resource "google_project_iam_member" "project_gke" {
  for_each = toset(local.bastion_iam)

  project = module.project.project_id
  role    = each.key
  member  = format("serviceAccount:%s", google_service_account.gke_service_account.email)
}

module "non_prod_management_cluster" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/gke-cluster-standard?ref=v24.0.0"

  project_id = module.project.project_id
  name       = "np-mgmt-cluster-gcp"
  location   = var.zone
  vpc_config = {
    network    = module.vpc.name
    subnetwork = module.vpc.subnets[local.subnet_name].name
    secondary_range_names = {
      pods     = "pods"
      services = "services"
    }
    # master_authorized_ranges = {
    #   internal-vms = "10.0.0.0/8"
    # }
    master_ipv4_cidr_block = var.gke_settings["master_ip_cidr"]
  }

  min_master_version = var.gke_settings["version"]

  enable_addons = {
    config_connector               = true
    gce_persistent_disk_csi_driver = true
  }

  enable_features = {
    shielded_nodes    = true
    dataplane_v2      = true
    autopilot         = false
    workload_identity = true
  }

  release_channel = var.gke_settings["release_channel"]

  private_cluster_config = var.gke_settings["private"] == false ? null : {
    enable_private_endpoint = true
    master_global_access    = false
  }

  labels = var.labels
  tags   = ["tenant"]
}

module "non_prod_management_cluster_node_pool" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/gke-nodepool?ref=v24.0.0"

  project_id   = module.project.project_id
  cluster_name = module.non_prod_management_cluster.name
  location     = var.zone
  name         = format("%s-nodepool-1", module.non_prod_management_cluster.name)
  gke_version  = var.gke_settings["version"]

  node_count = {
    initial = var.gke_settings["count"]
  }

  node_config = {
    disk_size_gb                  = var.gke_settings["disk_size_gb"]
    machine_type                  = var.gke_settings["machine_type"]
    workload_metadata_config_mode = "GKE_METADATA"
    image_type                    = "COS_CONTAINERD"
    shielded_instance_config = {
      enable_secure_boot = true
    }
    spot = var.gke_settings["spot"]
  }

  nodepool_config = {
    management = {
      auto_repair  = true
      auto_upgrade = true
    }
  }

  service_account = {
    create = false
    email  = google_service_account.gke_service_account.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  tags = ["tenant"]
}