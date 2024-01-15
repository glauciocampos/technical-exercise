output "private_ips" {
  value =  "${oci_container_instances_container_instance.webapp.*.vnics.0.private_ip}"
}