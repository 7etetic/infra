provider "google" {
  project = "infra-216911"
  region = "europe-west1"
}

// Define VM resource
resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "europe-west1-b"
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
  metadate {
    sshKeys = "appuser:${file("~/.ssh/appuser.pub")}"
  }
}
