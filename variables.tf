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
default =  <<-EOT
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACB0GCJiBKVhjud/cupd2c+k0KW/rq3Bp8kKle6+EZesZwAAAKBa3qAvWt6g
LwAAAAtzc2gtZWQyNTUxOQAAACB0GCJiBKVhjud/cupd2c+k0KW/rq3Bp8kKle6+EZesZw
AAAEAgMRbCo9Eqtj/p4ImPWfawMoZxZj3/9w5KjQtHUPJuD3QYImIEpWGO539y6l3Zz6TQ
pb+urcGnyQqV7r4Rl6xnAAAAFmNpYmVyb2xtb3NAaG90bWFpbC5jb20BAgMEBQYH
-----END OPENSSH PRIVATE KEY-----
EOT
}