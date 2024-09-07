provider "oci" {
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaamjuer35qocbf65c7wqqlmyjmeinuc3t7q7pgmv5gfmgjdvqzjp3a"
  user_ocid = "ocid1.user.oc1..aaaaaaaaqgceooek2o6edewot5g4zhrzsprxnltzqmm4dgmjwzbygft4e6kq" 
  private_key_path = "C:/Users/DELL/Downloads/jayaram059@gmail.com_2024-08-25T05_49_40.774Z.pem"
  fingerprint = "cb:86:38:8f:40:f0:1d:ab:9c:ae:0e:34:30:8b:ec:33"
  region = "ap-hyderabad-1"
}

# (Terraform version >= 1.6.4)
terraform {
  backend "s3" {
    bucket                    = "terraform-states"
    region                    = "ap-hyderabad-1"
    key                       = "tf.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    use_path_style              = true
    skip_s3_checksum            = true
    skip_metadata_api_check = true
    endpoints = {
      s3 = "https://axvjenufkdre.compat.objectstorage.ap-hyderabad-1.oraclecloud.com"
    }
  }
}
