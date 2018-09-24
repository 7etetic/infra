provider "google" {
  project = "infra-216911"
  region = "europe-west1"
}

// Define VM resource
resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "europe-west1-b"
  tags         = ["reddit-app"]
  // Define boot disk
  boot_disk {
    initialize_params {
      image = "reddit-base-1537535643"
    }
  }
  // Define network interface
  network_interface {
     // Connection network for interface
     network = "default"
     // Use ephemerial IP for an access from Internet
    access_config {}
  }
  // Add SSH key
  metadata {
    sshKeys = "appuser:${file("~/.ssh/appuser.pub")}"
  }
  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file("~/.ssh/appuser")}"
  }
  // Define provisioners
  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }
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
