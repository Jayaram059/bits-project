resource "oci_identity_policy" "api_functions_policy" {
  compartment_id = var.parent_compartment_ocid
  name           = var.policies_name
  description    = "Policy for API Gateway and OCI Functions to access necessary resources"

  statements = [
    # API Gateway needs to access OCI Functions
    "Allow dynamic-group ${var.dynamic_group_ocid} to use functions-family in tenancy",

    # API Gateway needs access to VCN
    "Allow dynamic-group ${var.dynamic_group_ocid} to use virtual-network-family in tenancy",

    # OCI Functions need to read secrets (if you're using secrets, adjust as needed)
    "Allow dynamic-group ${var.dynamic_group_ocid} to read secret-family in tenancy",

    # General policy to manage objects
    "Allow dynamic-group ${var.dynamic_group_ocid} to manage objects in tenancy"
  ]
}

output "policy_ocid" {
  value = oci_identity_policy.api_functions_policy.id
}

