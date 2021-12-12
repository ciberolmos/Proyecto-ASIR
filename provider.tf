#Estado remoto de terraform.
#terraform {
 #backend "gcs" {
    #bucket      = "terraform-bucket-proyecto-asir"
    #prefix      = "terraform/state/default.tfstate"
    #credentials = "kubernetes.json"
 #}
#}
#Credenciales para conectarse a google.
provider "google" {

  credentials = file("kubernetes.json")

  project = var.project_id
  region  = var.region
  zone    = var.zone
}
# Obtener datos de la cuenta para utilizarlos. En este caso para el token de autenticación.


data "google_client_config" "current" {
}
#Configuración para poder crear recursos en kubernetes, se utiliza un provider. (Se utiliza el data anterior)
provider "kubernetes" {
  host                   = "https://${google_container_cluster.primary.endpoint}"
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
  token                  = data.google_client_config.current.access_token
}

# Configuración para desplegar mediante helm, se utiliza un provider. (Se hace uso también del data)
provider "helm" {

  kubernetes {
    host  = google_container_cluster.primary.endpoint
    token = data.google_client_config.current.access_token

    client_certificate     = base64decode(google_container_cluster.primary.master_auth.0.client_certificate)
    client_key             = base64decode(google_container_cluster.primary.master_auth.0.client_key)
    cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
  }
}