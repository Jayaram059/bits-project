variable "compartment_id" {
  description = "The OCID of the compartment"
}

variable "public_subnet_id" {
  description = "The OCID of the public subnet"
}

variable "api_gateway_name" {
  description = "The name of the API Gateway"
}

variable "function_id" {
  description = "The ID of the OCI Function"
  default = ""
}

variable "api_gateway_id" {
  description = "The ID of the API Gateway"
}

variable "bits_authentication_servers" {
  description= "Created By Jayaran"
  default = {
  }


}

variable "tenancy_id" {
  description = "Tenancy Ocid"
  type    	= string
  default 	= ""
}

variable "environment" {
  description = "Name of the environment POD e.g prod, qa, demo, trial"
  type    	= string
  default 	= ""
}

variable "region_key" {
  description = "Region identification key e.g iad, fra"
  type    	= string
  default 	= ""
}

variable "parent_compartment_id" {
  description = "Parent compartment for POD deployment e.g. production, demo"
  type    	= string
  default 	= ""
}

variable "app_compartment_name" {
  description = "Compartment name for CXU application deployments"
  default 	= "app"
  type    	= string
}

variable "network_compartment_name" {
  description = "Compartment name for CXU network deployments"
  default 	= "network"
  type    	= string
}


variable "auth_validation_policy_type" {
  description = "Type of Auth for validation"
  default 	= "REMOTE_JWKS"
}



variable "public_apigw_dest_port" {
  description = "public apigw dest port"
  default 	= "443"
}

variable "public_ingress_security_rule_ip" {
  description = "public ingress security rule ip"
  default 	= "0.0.0.0/0"
}

variable "public_egress_security_rule_ip" {
  description = "public egress security rule ip"
  default 	= "0.0.0.0/0"
}

variable "private_ingress_security_rule_ip" {
  description = "private ingress security rule ip"
  default 	= "0.0.0.0/0"
}

variable "private_egress_security_rule_ip" {
  description = "private egress security rule icmp ip"
  default 	= "0.0.0.0/0"
}

variable "bits_function_api_path" {
  description = "bits function path"
  default 	= "/genai"
}

variable "bits_function_api_path_24a" {
  description = "bits function path 24a"
  default 	= "/sl"
}

variable "bits_function_api_path" {
  description = "bits function path"
  default 	= "/genai"
}

variable "bits_fun_concurrency_count" {
  description = "bits function concurrency count"
  default 	= "20"
}

variable "bits_fun_concurrency_count" {
  description = "bits function concurrency count"
  default 	= "20"
}

variable "bits_function_memory" {
  type	= number
  default = 512
}

variable "bits_function_timeout" {
  type	= number
  default = 180
}

variable "bits_function_memory" {
  type	= number
  default = 512
}

variable "bits_function_timeout" {
  type	= number
  default = 180
}

variable "public_subnet_cidr_block" {
  description = "public_subnet_cidr_block"
  default 	= "10.0.51.0/24"
}

variable "private_subnet_cidr_block" {
  description = "private_subnet_cidr_block"
  default 	= "10.0.52.0/24"
}

variable "authentication_type" {
  default 	= "JWT_AUTHENTICATION"
  description = "Details of the AUTH Type as IDCS"
}

variable "authentication_token_auth_scheme" {
  default 	= "Bearer"
  description = "Details of the AUTH Type as IDCS"
}

variable "authentication_token_header" {
  default 	= "Authorization"
  description = "Details of the AUTH Type as IDCS"
}

variable "authentication_issuers" {
  default 	= ["https://identity.oraclecloud.com/"]
  description = "Details of the AUTH Type as IDCS"
}

variable "loggig_comp_id" {
  default 	= "ocid1.compartment.oc1..aaaaaaaazpzfkeltxq3723mzsarac6z5fgret4ok32wyjvkkwn2g6nneumiq"
  description = "logging compartment ocid"
}

variable "public_rt_dest_ip" {
  description = "public route genai table dest ip"
  default 	= "0.0.0.0/0"
}

variable "private_rt_dest_ip" {
  description = "private route genai table dest ip"
  default 	= "0.0.0.0/0"
}

variable "idcs_url_cidr_block" {
  description = "IDCS URL CIDR block route genai table dest ip"
  default 	= ""
}

variable "bits_customer_tenants" {
  type = map(object({
	client_id = string
	secret	= string
  }))
  description = "list of bits tenants"
  default 	= {}
}

variable "bits_customer_tenants" {
  type = map(object({
	client_id = string
	secret	= string
  }))
  description = "list of bits tenants"
  default 	= {}
}



variable "genai_log_retention" {
  type	= number
  default = 180
}

locals {
  tags = {
	"team"  	= "ds"
	"service"   = "genai"
	"terraform" = "tf-genai"
  }

  app_name_prefix = "genai"
  name_prefix 	= "${var.region_key}-${var.environment}"

  bits_name_prefix = "${local.name_prefix}-bits-${local.app_name_prefix}"
  bits_name_prefix = "${local.name_prefix}-bits-${local.app_name_prefix}"

  # function
  bits_app_name   	= "${local.bits_name_prefix}-fnapp"
  bits_app_name  	= "${local.bits_name_prefix}-fnapp"
  bits_function_name  = "${local.bits_name_prefix}-fn"
  bits_function_name = "${local.bits_name_prefix}-fn"


  #apigw
  apigw_display_name     	= "${local.name_prefix}-apigw"
  bits_apigw_deployment_name  = "${local.bits_name_prefix}-deployment"
  bits_apigw_deployment_name = "${local.bits_name_prefix}-deployment"

  # log
  lg_display_name      	= "${local.name_prefix}-lg"
  bits_fn_log_display_name = "${local.bits_name_prefix}-fn-log"
  bits_fn_log_display_name  = "${local.bits_name_prefix}-fn-log"
  bits_apigw_log_name  	= "${local.bits_name_prefix}-apigw-log"
  bits_apigw_log_name   	= "${local.bits_name_prefix}-apigw-log"
  bits_apigw_exe_log_name  = "${local.bits_name_prefix}-apigw-exe-log"
  bits_apigw_exe_log_name   = "${local.bits_name_prefix}-apigw-exe-log"

  # policy
  pol_display_name = "${local.name_prefix}-pol"

  # dynamic group
  dg_display_name = "${local.name_prefix}-dg"

  # vault
  vlt_display_name     	= "${local.name_prefix}-vlt"
  key_display_name     	= "${local.name_prefix}-key"
  idcs_client_display_name = "${local.name_prefix}-clientId"
  idcs_secret_display_name = "${local.name_prefix}-secret"
  vault_name_prefix    	= local.name_prefix

  # compartment
  cmp_display_name = "genai"

  # bucket
  bucket_display_name = "${local.name_prefix}-bucket"
  
}


