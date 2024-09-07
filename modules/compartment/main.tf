resource "oci_identity_compartment" "compartment" {
  name           = var.compartment_name
  description    = "Compartment for bitsproject resources"
  compartment_id = var.parent_compartment_ocid
}

output "compartment_id" {
  value = oci_identity_compartment.compartment.id
}

