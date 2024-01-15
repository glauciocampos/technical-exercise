# https://docs.oracle.com/en-us/iaas/tools/terraform-provider-oci/5.23/docs/r/database_autonomous_database.html

data "oci_database_autonomous_database" "webapp_autonomous_database" {
    #Required
    autonomous_database_id = oci_database_autonomous_database.webapp_autonomous_database.id
}

resource "oci_database_autonomous_database" "webapp_autonomous_database" {
	compartment_id = var.global.compartment_ocid
	db_name = var.database.autonomous_database_db_name
	is_free_tier = var.database.autonomous_database_is_free_tier
	admin_password = var.database.autonomous_database_admin_password

	is_auto_scaling_enabled = var.database.autonomous_database_is_auto_scaling_enabled
	is_auto_scaling_for_storage_enabled = var.database.autonomous_database_is_auto_scaling_for_storage_enabled
	#database_nsg_id = var.database.database_nsg_id
}