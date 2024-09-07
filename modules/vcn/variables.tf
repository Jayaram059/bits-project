variable "compartment_id" {
  description = "The compartment OCID"
}

variable "vcn_name" {
  description = "Name of the VCN"
}

variable "vcn_cidr" {
  description = "CIDR block for the VCN"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
}

variable "egress_ip" {
  description = "Specific IP for outbound traffic"
}

