variable "tenancy_ocid" {
  description = "OCI Tenancy OCID"
}

variable "user_ocid" {
  description = "OCI User OCID"
}

variable "fingerprint" {
  description = "Fingerprint for OCI API Key"
}

variable "private_key_path" {
  description = "Path to the private key for OCI API"
}

variable "region" {
  description = "OCI Region"
}

variable "compartment_name" {
  description = "The name of the new compartment"
}

variable "parent_compartment_ocid" {
  description = "The OCID of the parent compartment"
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
  description = "The specific IP address for outbound traffic egress rule"
}

variable "api_gateway_name" {
  description = "The name of the API Gateway"
}

variable "function_app_name" {
  description = "The name of the OCI Functions Application"
}

variable "function_name" {
  description = "The name of the OCI Function"
}

variable "function_id" {
  description = "The name of the OCI Function"
  default     = ""
}
variable "function_image" {
  description = "The Docker image for the OCI Function"
}

variable "dynamic_group_name" {
  description = "The name of the dynamic group"
  default     = "bitsproject_dynamic_group"
}

variable "policies_name" {
  description = "The name of the policies for the API Gateway and Functions"
  default     = "bitsproject_api_functions_policy"
}
variable "bucket_name" {
  description = "The name of the OCI Object Storage bucket"
  default     = "bitsproject-terraform-state"
}

