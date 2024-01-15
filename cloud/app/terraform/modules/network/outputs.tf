output "vcn" {
  description = "vcn and gateways information"
  value = {
    vcn_id                       = module.vcn.vcn_id
  }
}

output "database_subnet_id" {
  description = "vcn and gateways information"
  value = {
    vcn_id = module.vcn.vcn_id
  }
}