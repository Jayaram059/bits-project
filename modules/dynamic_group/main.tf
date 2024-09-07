resource "oci_identity_dynamic_group" "dynamic_group" {
  compartment_id = var.parent_compartment_ocid
  name           = var.dynamic_group_name
  description    = "Dynamic group for bitsproject API Gateway and OCI Functions"

  matching_rule = <<EOF
ALL {resource.type = 'ApiGateway', resource.type = 'fnfunc'}
EOF
}

output "dynamic_group_ocid" {
  value = oci_identity_dynamic_group.dynamic_group.id
}

