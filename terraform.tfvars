tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaamjuer35qocbf65c7wqqlmyjmeinuc3t7q7pgmv5gfmgjdvqzjp3a"
user_ocid        = "ocid1.user.oc1..aaaaaaaaqgceooek2o6edewot5g4zhrzsprxnltzqmm4dgmjwzbygft4e6kq"
fingerprint      = "cb:86:38:8f:40:f0:1d:ab:9c:ae:0e:34:30:8b:ec:33"
private_key_path = "C:/Users/DELL/Downloads/jayaram059@gmail.com_2024-08-25T05_49_40.774Z.pem"
region           = "ap-hyderabad-1"

compartment_name        = "bitsproject_compartment"
parent_compartment_ocid = "ocid1.tenancy.oc1..aaaaaaaamjuer35qocbf65c7wqqlmyjmeinuc3t7q7pgmv5gfmgjdvqzjp3a"

vcn_name            = "bitsproject_vcn"
vcn_cidr            = "10.0.0.0/16"
public_subnet_cidr  = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"
egress_ip           = "138.1.33.162/32"

api_gateway_name  = "bitsproject_api_gateway"
function_app_name = "bitsproject_function_app"
function_name     = "bitsproject_function"
function_image    = "hyd.ocir.io/axvjenufkdre/bits-genai/jayaram059-genai:latest"

dynamic_group_name = "bitsproject_dynamic_group"
policies_name      = "bitsproject_api_functions_policy"

bucket_name = "bitsproject-terraform-state"

tj_authentication_servers = { for bits_tenant in local.bits_tenants : bits_tenant => {
  values    = [bits_tenant]
  issuers   = ["https://identity.oraclecloud.com/"]
  audiences = ["https://sandbox.bits.${bits_tenant}.ocs.oc-test.com"]
  uri       = "https://idcs-af93225cc99845dc91c457ca72fee84e.identity.preprod.oraclecloud.com/admin/v1/SigningCert/jwk"
  }
}

bits_authentication_servers = { for bits_tenant in local.bits_tenants : bits_tenant => {
  values    = [bits_tenant]
  issuers   = ["https://identity.oraclecloud.com/"]
  audiences = ["https://qa2.bits.${bits_tenant}.ocs.oc-test.com"]
  uri       = "https://idcs-af93225cc99845dc91c457ca72fee84e.identity.preprod.oraclecloud.com/admin/v1/SigningCert/jwk"
  }
}


