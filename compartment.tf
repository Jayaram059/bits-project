
resource "oci_identity_compartment" "tf-compartment" {
    # Required
    compartment_id = "ocid1.tenancy.oc1..aaaaaaaamjuer35qocbf65c7wqqlmyjmeinuc3t7q7pgmv5gfmgjdvqzjp3a"
    description = "Compartment for Terraform resources related to BITS Project."
    name = "bits-tf-compartment"
}