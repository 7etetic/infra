variable source_ranges {
  description = "Allowed IP addresses"
  default     = ["0.0.0.0/0"]
}

variable "description" {
  default     = ""
  description = "Textual description of firewall rule"
}

variable "name" {
  description = "A unique name for the firewall rule"
}

variable "ports" {
  description = "List of ports and/or port ranges to allow"
  type        = "list"
}
