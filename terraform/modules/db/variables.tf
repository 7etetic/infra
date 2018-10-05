variable "disk_image" {
  description = "The image from which to initialize the disk"
}

variable "firewall_name" {
  description = "A unique name for the firewall rule"
}

variable "firewall_ports" {
  description = "List of ports and/or port ranges to allow"
  type        = "list"
}

variable "username" {
  description = "Username used for ssh access"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable db_disk_image {
description = "Disk image for reddit db"
default     = "reddit-db-base"
}

variable "name" {
  description = "A unique name for the instance"
}

variable "source_tags" {
  description = "A list of source tags for firewall"
  type        = "list"
}

variable "tags" {
  description = "A list of tags to attach to the instance"
  type        = "list"
}
