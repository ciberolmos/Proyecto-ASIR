# Salidas de las variables y recursos de terraform/google

# ID proyecto y región

#output "project_id" {
#  value       = var.project_id
#  description = "GCloud Project ID"
#}

output "region" {
  value       = var.region
  description = "GCloud Region"
}


output "zone" {
  value       = var.zone
  description = "GCloud Zone"
}

# Kubernetes

output "gke_num_nodes" {
  value       = var.gke_num_nodes
  description = "number of gke nodes"
}

output "gke_username" {
  value       = var.gke_username
  description = "gke username"
}

output "gke_password" {
  value       = var.gke_password
  description = "gke password"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_endpoint" {
  value       = google_container_cluster.primary.endpoint
  description = "GKE Cluster Host"
}

# IPs

output "google_compute_global_address1" {
  value       = google_compute_address.ipv4_1.address
  description = "ipv4-address1"
}

output "google_compute_global_address2" {
  value       = google_compute_address.ipv4_2.address
  description = "ipv4-address2"
}

# Servidores que DNS que proporciona google
output "google_dns_managed_zone_name_servers" {
  value       = google_dns_managed_zone.parent_zone.name_servers
 description = "ipv4-address2"
}

# Value ssh-key
output "SSH_Argocd" {
value = var.SSH_Argocd
}