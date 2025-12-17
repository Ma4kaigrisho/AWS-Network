variable "first_vpc_ip" {
  type        = string
  description = "CIDR IPv4 for the first VPC"
  default     = "10.1.0.0/16"
}

variable "second_vpc_ip" {
  type        = string
  description = "CIDR IPv4 for the second VPC"
  default     = "10.2.0.0/16"
}