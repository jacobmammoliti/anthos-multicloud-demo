module "vpc" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-vpc?ref=v24.0.0"

  project_id = module.project.project_id
  name       = var.vpc_network_name
  subnets = [
    {
      ip_cidr_range = "10.0.0.0/24"
      name          = var.vpc_subnet_name
      region        = var.region
      secondary_ip_ranges = {
        pods     = "10.128.0.0/14"
        services = "172.30.0.0/16"
      }
    }
  ]
}

module "firewall" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-vpc-firewall?ref=v24.0.0"

  project_id = module.project.project_id
  network    = module.vpc.name

  ingress_rules = {}
}