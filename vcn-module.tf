# 1. Create a Virtual Cloud Network (VCN)
resource "oci_core_vcn" "example_vcn" {
  cidr_block   = "10.0.0.0/16"
  display_name = "example_vcn"
  compartment_id = "ocid1.compartment.oc1..aaaaaaaad7cgjhk5u3pdthcqgrizv7bs35orut3ief7q4ivrtsec3tayrmyq"
}

# 2. Create an Internet Gateway (for the public subnet)
resource "oci_core_internet_gateway" "example_igw" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaad7cgjhk5u3pdthcqgrizv7bs35orut3ief7q4ivrtsec3tayrmyq"
  vcn_id         = oci_core_vcn.example_vcn.id
  display_name   = "example_igw"
  enabled        = true
}

# 3. Create a Route Table (for the public subnet)
resource "oci_core_route_table" "public_rt" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaad7cgjhk5u3pdthcqgrizv7bs35orut3ief7q4ivrtsec3tayrmyq"
  vcn_id         = oci_core_vcn.example_vcn.id
  route_rules {
    cidr_block = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.example_igw.id
  }
}

# 4. Create a Security List (optional, allow all ingress/egress traffic)
resource "oci_core_security_list" "public_sl" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaad7cgjhk5u3pdthcqgrizv7bs35orut3ief7q4ivrtsec3tayrmyq"
  vcn_id         = oci_core_vcn.example_vcn.id
  egress_security_rules {
    protocol = "all"
    destination = "0.0.0.0/0"
  }
  ingress_security_rules {
    protocol = "all"
    source = "0.0.0.0/0"
  }
}

resource "oci_core_security_list" "private_sl" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaad7cgjhk5u3pdthcqgrizv7bs35orut3ief7q4ivrtsec3tayrmyq"
  vcn_id         = oci_core_vcn.example_vcn.id
  egress_security_rules {
    protocol = "all"
    destination = "0.0.0.0/0"
  }
  ingress_security_rules {
    protocol = "all"
    source = "10.0.0.0/16"
  }
}

# 5. Create the Public Subnet
resource "oci_core_subnet" "public_subnet" {
  compartment_id      = "ocid1.compartment.oc1..aaaaaaaad7cgjhk5u3pdthcqgrizv7bs35orut3ief7q4ivrtsec3tayrmyq"
  vcn_id              = oci_core_vcn.example_vcn.id
  cidr_block          = "10.0.1.0/24"
  display_name        = "public_subnet"
  route_table_id      = oci_core_route_table.public_rt.id
  security_list_ids   = [oci_core_security_list.public_sl.id]
  dhcp_options_id     = oci_core_vcn.example_vcn.default_dhcp_options_id
  prohibit_public_ip_on_vnic = false
}

# 6. Create the Private Subnet
resource "oci_core_subnet" "private_subnet" {
  compartment_id      = "ocid1.compartment.oc1..aaaaaaaad7cgjhk5u3pdthcqgrizv7bs35orut3ief7q4ivrtsec3tayrmyq"
  vcn_id              = oci_core_vcn.example_vcn.id
  cidr_block          = "10.0.2.0/24"
  display_name        = "private_subnet"
  security_list_ids   = [oci_core_security_list.private_sl.id]
  dhcp_options_id     = oci_core_vcn.example_vcn.default_dhcp_options_id
  prohibit_public_ip_on_vnic = true
}