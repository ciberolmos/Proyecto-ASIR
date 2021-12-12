# Con este fichero se crea la zona dns y sus registros, previamente hay que tener comprado el dominio
# una vez realizado mediante el atributo "name_servers" se averiguan los servidores dns asignados por google
# y se modifican en el dominio.

# Creando la zona dns
resource "google_dns_managed_zone" "parent_zone" {
  #  provider = "google-beta"
  name        = "zone-arp"
  dns_name    = "proyecto-asir.com."
  description = "Zona DNS del proyecto asir"
}

#Añadiendo el registro "A" de app a la zona dns
resource "google_dns_record_set" "app_dns" {
  #  provider = "google-beta"
  managed_zone = google_dns_managed_zone.parent_zone.name
  name         = "app.proyecto-asir.com."
  type         = "A"
  rrdatas      = [google_compute_address.ipv4_1.address]
  ttl          = 86400
  depends_on = [
    helm_release.helm_ingress_controler_sock-shop
  ]
}

#Añadiendo el registro "A" de tools a la zona dns 
resource "google_dns_record_set" "tools_dns" {
  #  provider = "google-beta"
  managed_zone = google_dns_managed_zone.parent_zone.name
  name         = "tools.proyecto-asir.com."
  type         = "A"
  rrdatas      = [google_compute_address.ipv4_2.address]
  ttl          = 86400
  depends_on = [
    helm_release.helm_ingress_controler_herramientas
  ]
}

#Añadiendo el registro "CNAME" de calcetines a la zona dns 
resource "google_dns_record_set" "calcetines_dns" {
  #  provider = "google-beta"
  managed_zone = google_dns_managed_zone.parent_zone.name
  name         = "calcetines.proyecto-asir.com."
  type         = "CNAME"
  rrdatas      = ["app.proyecto-asir.com."]
  ttl          = 86400
  depends_on = [
    helm_release.helm_ingress_controler_sock-shop
  ]
}

#Añadiendo el registro "CNAME" de argocd a la zona dns 
resource "google_dns_record_set" "argocd_dns" {
  #  provider = "google-beta"
  managed_zone = google_dns_managed_zone.parent_zone.name
  name         = "argocd.proyecto-asir.com."
  type         = "CNAME"
  rrdatas      = ["tools.proyecto-asir.com."]
  ttl          = 86400
  depends_on = [
    helm_release.helm_ingress_controler_herramientas
  ]
}