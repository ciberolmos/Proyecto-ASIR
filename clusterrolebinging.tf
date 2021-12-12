# Data para acceder a la información del usuario de terraform
data "google_client_openid_userinfo" "terraform_user" {}
# Permisos para poder crear y desplegar recursos en el cluster.
resource "kubernetes_cluster_role_binding" "user" {
  metadata {
    name = var.gke_username
  }

  role_ref {
    kind      = "ClusterRole"
    name      = "cluster-admin"
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "User"
    name      = data.google_client_openid_userinfo.terraform_user.email
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "Group"
    name      = "system:masters"
    api_group = "rbac.authorization.k8s.io"
  }
  depends_on = [
    google_container_node_pool.primary_nodes
  ]
}