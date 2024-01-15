
data "oci_identity_tenancy" "tenancy" {
  tenancy_id = var.global.tenancy_ocid
}

data "oci_identity_regions" "regions" {
}

data "oci_objectstorage_namespace" "objectstorage_namespace" {
}

data "oci_identity_region_subscriptions" "region_subscriptions" {
  tenancy_id = var.global.tenancy_ocid
}

resource "oci_identity_compartment" "webapp" {
  provider       = oci
  name           = var.global.compartment_ocid
  description    = "Compartment for OCM secrets."
  compartment_id = var.global.tenancy_ocid
}

resource "oci_identity_compartment" "webapp-kms" {
  provider       = oci
  name           = var.security.kms_compartment_ocid
  description    = "Compartment for WebApp secrets."
  compartment_id = var.global.tenancy_ocid
}