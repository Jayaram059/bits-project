# (Terraform version >= 1.6.4)
terraform {
  backend "s3" {
    bucket                      = "bitsproject-terraform-state"
    region                      = "ap-hyderabad-1"
    key                         = "tf.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    use_path_style              = true
    skip_s3_checksum            = true
    skip_metadata_api_check     = true
    endpoints = {
      s3 = "https://axvjenufkdre.compat.objectstorage.ap-hyderabad-1.oraclecloud.com"
    }
  }
}