provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

# Create the Compartment
module "bitsproject_compartment" {
  source                  = "./modules/compartment"
  compartment_name        = var.compartment_name
  parent_compartment_ocid = var.parent_compartment_ocid
}

# Create the VCN, Subnets, and Networking resources
module "bitsproject_vcn" {
  source              = "./modules/vcn"
  compartment_id      = module.bitsproject_compartment.compartment_id
  vcn_name            = var.vcn_name
  vcn_cidr            = var.vcn_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  egress_ip           = var.egress_ip
}
  
# Create the API Gateway
module "bitsproject_api_gateway" {
  source           = "./modules/api_gateway"
  compartment_id   = module.bitsproject_compartment.compartment_id
  public_subnet_id = module.bitsproject_vcn.public_subnet_id
  api_gateway_name = var.api_gateway_name
  function_id      = module.bitsproject_functions.function_id
  api_gateway_id   = module.bitsproject_api_gateway.api_gateway_id
}

# Create OCI Functions Application and Function
module "bitsproject_functions" {
  source            = "./modules/functions"
  compartment_id    = module.bitsproject_compartment.compartment_id
  public_subnet_id  = module.bitsproject_vcn.public_subnet_id
  function_app_name = var.function_app_name
  function_name     = var.function_name
  function_image    = var.function_image
  #api_gateway_id    = module.bitsproject_api_gateway.api_gateway_id
}

# Outputs
output "compartment_id" {
  value = module.bitsproject_compartment.compartment_id
}

output "vcn_id" {
  value = module.bitsproject_vcn.vcn_id
}

output "api_gateway_endpoint" {
  value = module.bitsproject_api_gateway.api_gateway_endpoint
}
# Create Policies for API Gateway and OCI Functions
module "bitsproject_policies" {
  source                  = "./modules/policies"
  compartment_id          = module.bitsproject_compartment.compartment_id
  parent_compartment_ocid = var.parent_compartment_ocid
  dynamic_group_ocid      = module.bitsproject_dynamic_group.dynamic_group_ocid
  policies_name           = var.policies_name
}

# Create a Dynamic Group
module "bitsproject_dynamic_group" {
  source = "./modules/dynamic_group"
  #compartment_id     = module.bitsproject_compartment.parent_compartment_ocid
  parent_compartment_ocid = var.parent_compartment_ocid
  dynamic_group_name      = var.dynamic_group_name
}





