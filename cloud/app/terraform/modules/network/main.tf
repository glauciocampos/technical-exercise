module "vcn" {
  source = "github.com/oracle-quickstart/terraform-oci-networking//modules/vcn?ref=0.2.0"

  compartment_ocid = var.global.compartment_ocid

  vcn_tags = local.oci_tag_values

  # Virtual Cloud Network (VCN) arguments
  create_new_vcn          = var.vcn.create_new_vcn 
  existent_vcn_ocid       = var.vcn.existent_vcn_ocid
  cidr_blocks             = var.vcn.cidr_blocks
  display_name            = var.vcn.display_name
  dns_label               = var.vcn.dns_label
  is_ipv6enabled          = var.vcn.is_ipv6enabled
  ipv6private_cidr_blocks = var.vcn.ipv6private_cidr_blocks
}

module "subnets" {
  for_each = { for map in local.subnets : map.subnet_name => map }
  source   = "github.com/oracle-quickstart/terraform-oci-networking//modules/subnet?ref=0.2.0"

  compartment_ocid = var.global.compartment_ocid
  vcn_id           = module.vcn.vcn_id

  subnet_tags = local.oci_tag_values

  create_subnet              = true
  subnet_name                = each.value.subnet_name
  cidr_block                 = each.value.cidr_block
  display_name               = each.value.display_name # If null, is autogenerated
  dns_label                  = each.value.dns_label    # If null, is autogenerated
  prohibit_public_ip_on_vnic = each.value.prohibit_public_ip_on_vnic
  prohibit_internet_ingress  = each.value.prohibit_internet_ingress
  route_table_id             = each.value.route_table_id    # If null, the VCN's default route table is used
  dhcp_options_id            = each.value.dhcp_options_id   # If null, the VCN's default set of DHCP options is used
  security_list_ids          = each.value.security_list_ids # If null, the VCN's default security list is used
  ipv6cidr_block             = each.value.ipv6cidr_block    # If null, no IPv6 CIDR block is assigned
}

locals {
  oci_tag_values = {
    "freeformTags" = {"CreatedBy" = "Terraform"},
    "definedTags"  = {}
  }
  subnets = var.subnets
}