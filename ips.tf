#IP fijas para los ingress
resource "google_compute_address" "ipv4_1" {
  name = "ipv4-address1"
}

resource "google_compute_address" "ipv4_2" {
  name = "ipv4-address2"
}
