data "oci_identity_availability_domains" "ADs" {
  compartment_id = var.global.compartment_ocid
}

resource "oci_container_instances_container_instance" "webapp" {
  count = var.ci.ci_count
  compartment_id           = var.global.compartment_ocid
  display_name             = var.ci.ci_name
  availability_domain      = var.global.availability_domains
  container_restart_policy = var.ci.ci_restart_policy
  state                    = var.ci.ci_state
  shape                    = var.ci.ci_shape
  shape_config {
    ocpus         = var.ci.ci_ocpus
    memory_in_gbs = var.ci.ci_memory
  }
  vnics {
    display_name           = "nic_webapp_${count.index}"
    hostname_label         = "hostname_webapp_${count.index}"
    subnet_id              = var.ci.private_subnet_ocid
    skip_source_dest_check = false
    is_public_ip_assigned  = var.ci.is_public_ip_assigned
  }
  containers {
    display_name          = "${var.ci.ci_container_name}${count.index}"
    image_url             = var.ci.ci_image_url
  }

  image_pull_secrets {
        #Required
        registry_endpoint = var.ci.registry_endpoint
        #secret_type = "BASIC"
        #username = base64encode("username")
        #password = base64encode("password")
        secret_type = "VAULT"
        secret_id = var.ci.ci_registry_secret
    }
}