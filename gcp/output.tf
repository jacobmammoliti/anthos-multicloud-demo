output "gke_connect_string" {
  description = "GKE connection string."
  value       = format("gcloud container clusters get-credentials np-mgmt-cluster-gcp --zone %s --project %s", var.zone, module.project.project_id)
}