# GKE cluster, crea el cluster y borra el nodo por defecto.
resource "google_container_cluster" "primary" {
  name     = "proyecto-asir-gke"
  location = var.zone

  remove_default_node_pool = true
  initial_node_count       = 1

  # Deshabilitamos el balanceador por defecto y el autoescalado horizontal de los pods.
  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = true
    }
  }

  network    = google_compute_network.vpc_proyecto_asir.name
  subnetwork = google_compute_subnetwork.subnet_proyecto_asir.name

  depends_on = [
    google_compute_network.vpc_proyecto_asir,
    google_compute_subnetwork.subnet_proyecto_asir
  ]
}

# Creamos los nodos despues de desplegar el cluster en este caso 2.
resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.primary.name}-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes

  # Addon GKE autoscaler tipo balanced. Autoescala hasta 5
  autoscaling {
    max_node_count = 5
    min_node_count = 2
  }
  # Ignoramos el node_count para que cuando autoescale no intente modificarlo, (cuando difiere del numero de nodos indicados inicialmente)
  lifecycle {
    ignore_changes = [
      node_count,
    ]
  }
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    machine_type = "e2-medium"
    tags         = ["gke-node", "proyecto-asir-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}