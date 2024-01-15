provider "oci" {
  ### These information are needed only outside of OCI Terraform Stack Manager
  tenancy_ocid     = var.global.tenancy_ocid
  user_ocid        = var.global.user_ocid
  fingerprint      = var.global.fingerprint
  private_key_path = var.global.private_key_path
  region           = var.global.region
}

# ## Required for IAM resource creation. IAM resource must be created in the tenancy home region.
provider "oci" {
  alias            = "homeregion"
  tenancy_ocid     = var.global.tenancy_ocid
  user_ocid        = var.global.user_ocid
  fingerprint      = var.global.fingerprint
  private_key_path = var.global.private_key_path
  region           = var.global.region
}
