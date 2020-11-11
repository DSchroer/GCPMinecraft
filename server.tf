
resource "google_compute_instance" "vm_instance" {
  name           = var.name
  machine_type   = var.machine_type
  desired_status = "RUNNING"
  tags           = ["web"]

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  scheduling {
    preemptible       = true
    automatic_restart = false
  }

  metadata = {
    user-data = templatefile("${path.module}/cloud-config.yml", {
      image         = var.docker_image
      world_path    = var.world_path
      time_zone     = var.time_zone
      shutdown_time = var.shutdown_time
    })
  }
}