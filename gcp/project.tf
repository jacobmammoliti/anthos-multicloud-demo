resource "random_pet" "project_name" {
  length = 3
}

module "project" {
  source = "github.com/GoogleCloudPlatform/cloud-foundation-fabric.git//modules/project?ref=v24.0.0"

  billing_account = var.billing_account
  name            = random_pet.project_name.id
  parent          = var.parent
  services        = var.enabled_services
  iam = {
    "roles/gkehub.serviceAgent" = [
      "serviceAccount:${module.project.service_accounts.robots.fleet}"
    ]
  }
}