## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.3 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.74.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.74.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_firewall"></a> [firewall](#module\_firewall) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-vpc-firewall | v24.0.0 |
| <a name="module_non_prod_management_cluster"></a> [non\_prod\_management\_cluster](#module\_non\_prod\_management\_cluster) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/gke-cluster-standard | v24.0.0 |
| <a name="module_non_prod_management_cluster_node_pool"></a> [non\_prod\_management\_cluster\_node\_pool](#module\_non\_prod\_management\_cluster\_node\_pool) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/gke-nodepool | v24.0.0 |
| <a name="module_project"></a> [project](#module\_project) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/project | v24.0.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/net-vpc | v24.0.0 |

## Resources

| Name | Type |
|------|------|
| [google_project_iam_member.project_gke](https://registry.terraform.io/providers/hashicorp/google/4.74.0/docs/resources/project_iam_member) | resource |
| [google_service_account.gke_service_account](https://registry.terraform.io/providers/hashicorp/google/4.74.0/docs/resources/service_account) | resource |
| [random_pet.project_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | (required) Billing account to attach to the project. | `string` | n/a | yes |
| <a name="input_enabled_services"></a> [enabled\_services](#input\_enabled\_services) | (optional) List of service APIs to enable. | `list(string)` | <pre>[<br>  "container.googleapis.com",<br>  "stackdriver.googleapis.com",<br>  "servicenetworking.googleapis.com",<br>  "gkehub.googleapis.com",<br>  "gkeconnect.googleapis.com",<br>  "gkebackup.googleapis.com",<br>  "anthosconfigmanagement.googleapis.com",<br>  "multiclusteringress.googleapis.com",<br>  "multiclusterservicediscovery.googleapis.com",<br>  "mesh.googleapis.com",<br>  "redis.googleapis.com",<br>  "anthos.googleapis.com",<br>  "gkemulticloud.googleapis.com"<br>]</pre> | no |
| <a name="input_gke_settings"></a> [gke\_settings](#input\_gke\_settings) | (optional) Map of node pool settings. | <pre>object({<br>    count           = number<br>    disk_size_gb    = number<br>    machine_type    = string<br>    master_ip_cidr  = string<br>    spot            = bool<br>    preemptible     = bool<br>    private         = bool<br>    version         = string<br>    release_channel = string<br>  })</pre> | <pre>{<br>  "count": 3,<br>  "disk_size_gb": 10,<br>  "machine_type": "n2-standard-4",<br>  "master_ip_cidr": "192.168.0.0/28",<br>  "preemptible": true,<br>  "private": false,<br>  "release_channel": "RAPID",<br>  "spot": true,<br>  "version": "1.27.2-gke.2100"<br>}</pre> | no |
| <a name="input_labels"></a> [labels](#input\_labels) | (optional) Map of labels to assign to infrastructure deployed. | `map(string)` | <pre>{<br>  "environment": "non-production"<br>}</pre> | no |
| <a name="input_parent"></a> [parent](#input\_parent) | (required) Parent folder or oranization to place the project in. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | (optional) Default GCP region to deploy to. | `string` | `"us-central1"` | no |
| <a name="input_vpc_network_name"></a> [vpc\_network\_name](#input\_vpc\_network\_name) | (optional) Name of the VPC network to use. | `string` | `"default"` | no |
| <a name="input_vpc_subnet_name"></a> [vpc\_subnet\_name](#input\_vpc\_subnet\_name) | (optional) Name of the VPC subnetwork to use. | `string` | `"default"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | (optional) Default GCP zone to deploy to. | `string` | `"us-central1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gke_connect_string"></a> [gke\_connect\_string](#output\_gke\_connect\_string) | GKE connection string. |
