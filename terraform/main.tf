provider "google" {
  project = "${var.project}"
  region = "${var.region}"
}

// Define VM resource
resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]
  // Define boot disk
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }
  // Define network interface
  network_interface {
     // Connection network for interface
     network = "default"
     // Use ephemerial IP for an access from Internet
    access_config {
      nat_ip =  "${google_compute_address.app_ip.address}"
    }
  }
  // Add SSH key
  metadata {
    sshKeys = "appuser:${file("${var.public_key_path}")}"
  }
  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file("${var.private_key_path}")}"
  }
  // Define provisioners
#  provisioner "file" {
#    source      = "files/puma.service"
#    destination = "/tmp/puma.service"
#  }
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

//Define firewall rules
resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  // Network name for the rule
  network = "default"
  // Kind of access to allow
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  // Allowed IP range
  source_ranges = ["0.0.0.0/0"]
  // Rule applicable for tags
  target_tags = ["reddit-app"]
}

resource "google_compute_firewall" "firewall_ssh" {
  name    = "default-allow-ssh"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}
