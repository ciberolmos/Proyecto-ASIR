# Definición de las variables

# ID proyecto,región y zona
variable "project_id" {
default = "proyecto-asir-333123"
  description = "GCloud Project ID"
}

variable "region" {
  default = "us-west1"
  description = "Gloud Region"
}

variable "zone" {
  default = "us-west1-a"  
  description = "Gloud zone"
}

# Kubernetes

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}

variable "gke_username" {
  default     = "olmos"
  description = "gke username"
}

variable "gke_password" {
  default     = "4430"
  description = "gke password"
}

variable "SSH_Argocd" {
default =  ""
}