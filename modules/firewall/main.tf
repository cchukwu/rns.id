##rns.id/modules/firewall/main.tf

resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal"
  network = var.network

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["10.0.0.0/8"]
}

resource "google_compute_firewall" "allow_external" {
  name    = "allow-external"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  target_tags   = ["allow-external"]
  source_ranges = ["0.0.0.0/0"]
}
