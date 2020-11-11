variable "name" {
  type = string
}

variable "domain" {
  type = string
}

variable "docker_image" {
  type = string
}

variable "world_path" {
  type = string
}

variable "machine_type" {
  type    = string
  default = "e2-standard-2"
}

variable "time_zone" {
  type    = string
  default = "America/Toronto"
}

variable "shutdown_time" {
  type    = string
  default = "00:00"
}