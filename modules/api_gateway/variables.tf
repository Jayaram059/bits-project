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

variable "tj_authentication_servers" {
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

variable "elq_function_api_path" {
  description = "elq function path"
  default 	= "/genai"
}

variable "elq_function_api_path_24a" {
  description = "elq function path 24a"
  default 	= "/sl"
}

variable "rsys_function_api_path" {
  description = "rsys function path"
  default 	= "/genai"
}

variable "rsys_fun_concurrency_count" {
  description = "rsys function concurrency count"
  default 	= "20"
}

variable "elq_fun_concurrency_count" {
  description = "elq function concurrency count"
  default 	= "20"
}

variable "rsys_function_memory" {
  type	= number
  default = 512
}

variable "rsys_function_timeout" {
  type	= number
  default = 180
}

variable "elq_function_memory" {
  type	= number
  default = 512
}

variable "elq_function_timeout" {
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
  default 	= ""
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

variable "elq_customer_tenants" {
  type = map(object({
	client_id = string
	secret	= string
  }))
  description = "list of elq tenants"
  default 	= {}
}

variable "rsys_customer_tenants" {
  type = map(object({
	client_id = string
	secret	= string
  }))
  description = "list of elq tenants"
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

  rsys_name_prefix = "${local.name_prefix}-rsys-${local.app_name_prefix}"
  elq_name_prefix = "${local.name_prefix}-elq-${local.app_name_prefix}"

  # function
  elq_app_name   	= "${local.elq_name_prefix}-fnapp"
  rsys_app_name  	= "${local.rsys_name_prefix}-fnapp"
  elq_function_name  = "${local.elq_name_prefix}-fn"
  rsys_function_name = "${local.rsys_name_prefix}-fn"


  #apigw
  apigw_display_name     	= "${local.name_prefix}-apigw"
  elq_apigw_deployment_name  = "${local.elq_name_prefix}-deployment"
  rsys_apigw_deployment_name = "${local.rsys_name_prefix}-deployment"

  # log
  lg_display_name      	= "${local.name_prefix}-lg"
  rsys_fn_log_display_name = "${local.rsys_name_prefix}-fn-log"
  elq_fn_log_display_name  = "${local.elq_name_prefix}-fn-log"
  rsys_apigw_log_name  	= "${local.rsys_name_prefix}-apigw-log"
  elq_apigw_log_name   	= "${local.elq_name_prefix}-apigw-log"
  rsys_apigw_exe_log_name  = "${local.rsys_name_prefix}-apigw-exe-log"
  elq_apigw_exe_log_name   = "${local.elq_name_prefix}-apigw-exe-log"

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


