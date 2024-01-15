output "nsgs" {
  description = "The Network Security Group(s) (NSGs) created/managed."
  value = {
    database_nsg_id = oci_core_network_security_group_security_rule.webapp_database_rule.id
  }
}