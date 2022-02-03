provider "google" {
    project = "anvil-and-terra-development"
    region = var.region
    zone = var.zone
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}

resource "google_compute_instance" "vm1" {
  name         = "terraform-benchmark-instance"
  machine_type = "c2-standard-16"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
      size = var.volume_size
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }
}
