resource "oci_core_vcn" "vcn" {
  cidr_block    = var.vcn_cidr
  display_name  = var.vcn_name
  compartment_id = var.compartment_id
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "bitsproject_igw"
  enabled        = true
}

resource "oci_core_route_table" "public_rt" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.vcn.id

  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

resource "oci_core_security_list" "public_sl" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.vcn.id

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 443
      max = 443
    }
  }

  egress_security_rules {
    protocol     = "all"
    destination  = "0.0.0.0/0"
  }

  egress_security_rules {
    protocol     = "6" # TCP
    destination  = var.egress_ip
    tcp_options {
      min = 443
      max = 443
    }
  }
}

resource "oci_core_subnet" "public_subnet" {
  compartment_id         = var.compartment_id
  vcn_id                 = oci_core_vcn.vcn.id
  cidr_block             = var.public_subnet_cidr
  route_table_id         = oci_core_route_table.public_rt.id
  security_list_ids      = [oci_core_security_list.public_sl.id]
  prohibit_public_ip_on_vnic = false
}

resource "oci_core_subnet" "private_subnet" {
  compartment_id         = var.compartment_id
  vcn_id                 = oci_core_vcn.vcn.id
  cidr_block             = var.private_subnet_cidr
  prohibit_public_ip_on_vnic = true
}

output "vcn_id" {
  value = oci_core_vcn.vcn.id
}

output "public_subnet_id" {
  value = oci_core_subnet.public_subnet.id
}

