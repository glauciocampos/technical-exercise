resource "oci_load_balancer" "flex_lb" {
  shape          = "flexible"
  compartment_id = var.global.compartment_ocid
  is_private = false

  subnet_ids = [
    var.lb.public_subnet_ocid
  ]

  shape_details {
    #Required
    maximum_bandwidth_in_mbps = var.lb.load_balancer_shape_details_maximum_bandwidth_in_mbps
    minimum_bandwidth_in_mbps = var.lb.load_balancer_shape_details_minimum_bandwidth_in_mbps
  }

  display_name = var.lb.lb_name
}

resource "oci_load_balancer_backend_set" "lb-bes1" {
  name             = "lb-bes1"
  load_balancer_id = oci_load_balancer.flex_lb.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = var.lb.lb_checker_health_port
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = var.lb.lb_checker_url_path
  }
}

resource "oci_load_balancer_backend" "lb-be1" {
  count = length(var.lb.private_ips)  
  load_balancer_id = oci_load_balancer.flex_lb.id
  backendset_name  = oci_load_balancer_backend_set.lb-bes1.name
  ip_address       = element(var.lb.private_ips, count.index)
  port             = var.lb.lb_backend_port
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_listener" "lb-listener1" {
  load_balancer_id         = oci_load_balancer.flex_lb.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.lb-bes1.name
  port                     = var.lb.lb_listener_port
  protocol                 = "HTTP"

  connection_configuration {
    idle_timeout_in_seconds = "10"
  }
}