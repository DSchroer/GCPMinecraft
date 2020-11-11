
resource "google_dns_managed_zone" "zone" {
  name     = "${var.name}-zone"
  dns_name = "${var.domain}."
}

resource "google_dns_record_set" "dns" {
  name = google_dns_managed_zone.zone.dns_name
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.zone.name

  rrdatas = [google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip]
}

resource "google_compute_firewall" "firewall" {
  name    = "${var.name}-firewall"
  network = "default"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["25565"]
  }

  allow {
    protocol = "udp"
    ports    = ["25565"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web"]
}