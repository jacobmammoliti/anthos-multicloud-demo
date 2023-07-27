variable "billing_account" {
  type        = string
  description = "(required) Billing account to attach to the project."
}

variable "enabled_services" {
  type        = list(string)
  description = "(optional) List of service APIs to enable."
  default = [
    "container.googleapis.com",
    "stackdriver.googleapis.com",
    "servicenetworking.googleapis.com",
    "gkehub.googleapis.com",
    "gkeconnect.googleapis.com",
    "gkebackup.googleapis.com",
    "anthosconfigmanagement.googleapis.com",
    "multiclusteringress.googleapis.com",
    "multiclusterservicediscovery.googleapis.com",
    "mesh.googleapis.com",
    "redis.googleapis.com",
    "anthos.googleapis.com",
    "gkemulticloud.googleapis.com",
  ]
}

variable "gke_settings" {
  type = object({
    count           = number
    disk_size_gb    = number
    machine_type    = string
    master_ip_cidr  = string
    spot            = bool
    preemptible     = bool
    private         = bool
    version         = string
    release_channel = string
  })
  description = "(optional) Map of node pool settings."
  default = {
    count           = 3                 # Number of nodes
    disk_size_gb    = 10                # Size of disk to attach to each node
    machine_type    = "n2-standard-4"   # Instance type to use for each node
    master_ip_cidr  = "192.168.0.0/28"  # CIDR range for GKE master nodes
    spot            = true              # Lower cost VMs built for fault-tolerant workloads
    preemptible     = true              # Mark the node as premmptible
    private         = false             # Whether nodes have internal IP addresses only
    version         = "1.27.2-gke.2100" # GKE version to use for master and worker nodes
    release_channel = "RAPID"           # GKE release channel to subscribe to
  }
}

variable "labels" {
  type        = map(string)
  description = "(optional) Map of labels to assign to infrastructure deployed."
  default = {
    "environment" = "non-production"
  }
}

variable "parent" {
  type        = string
  description = "(required) Parent folder or oranization to place the project in."
}

variable "region" {
  type        = string
  description = "(optional) Default GCP region to deploy to."
  default     = "us-central1"
}

variable "vpc_network_name" {
  type        = string
  description = "(optional) Name of the VPC network to use."
  default     = "default"
}

variable "vpc_subnet_name" {
  type        = string
  description = "(optional) Name of the VPC subnetwork to use."
  default     = "default"
}

variable "zone" {
  type        = string
  description = "(optional) Default GCP zone to deploy to."
  default     = "us-central1-a"
}
