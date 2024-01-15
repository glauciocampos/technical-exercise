resource "oci_core_network_security_group" "webapp" {
  compartment_id = var.global.compartment_ocid
  vcn_id         = var.vcn_id
  display_name   = "webapp-nsg"
}

resource "oci_core_network_security_group_security_rule" "webapp_http_ci_rule" {
    #Required
    network_security_group_id = oci_core_network_security_group.webapp.id
    direction = "INGRESS"
    protocol = "TCP"

    #Optional
    icmp_options {
        #Required
        type = 3

        #Optional
        code = 3
    }
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless = "true"
    tcp_options {

        #Optional
        destination_port_range {
            #Required
            max = 80
            min = 80
        }
        source_port_range {
            #Required
            max = 0
            min = 0
        }
    }
    udp_options {
    }
}

resource "oci_core_network_security_group_security_rule" "webapp_https_ci_rule" {
    #Required
    network_security_group_id = oci_core_network_security_group.webapp.id
    direction = "INGRESS"
    protocol = "TCP"

    #Optional
    icmp_options {
        #Required
        type = 3

        #Optional
        code = 3
    }
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless = "true"
    tcp_options {

        #Optional
        destination_port_range {
            #Required
            max = 443
            min = 443
        }
        source_port_range {
            #Required
            max = 0
            min = 0
        }
    }
    udp_options {
    }
}

resource "oci_core_network_security_group_security_rule" "webapp_database_rule" {
    #Required
    network_security_group_id = oci_core_network_security_group.webapp.id
    direction = "INGRESS"
    protocol = "TCP"

    #Optional
    icmp_options {
        #Required
        type = 3

        #Optional
        code = 3
    }
    source = "10.0.1.0/24"
    source_type = "CIDR_BLOCK"
    stateless = "true"
    tcp_options {

        #Optional
        destination_port_range {
            #Required
            max = 5432
            min = 5432
        }
        source_port_range {
            #Required
            max = 0
            min = 0
        }
    }
    udp_options {
    }
}

resource "oci_kms_vault" "webapp_kms" {
  display_name   = "Webpp KMS Secrets"
  compartment_id = var.security.kms_compartment_ocid
  vault_type     = "DEFAULT"
}

resource "oci_kms_key" "MainKey" {
  compartment_id = var.security.kms_compartment_ocid
  display_name   = "MainKey"
  key_shape {
    algorithm = "AES"
    length    = "32"
  }
  management_endpoint = oci_kms_vault.webapp_kms.management_endpoint
}