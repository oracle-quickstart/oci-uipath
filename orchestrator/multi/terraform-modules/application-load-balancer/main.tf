resource "oci_load_balancer_load_balancer" "test_load_balancer" {
    #Required
    compartment_id = "${var.compartment_id}"
    display_name = "${var.load_balancer_display_name}"
    shape = "${var.load_balancer_shape}"
    subnet_ids = "${var.load_balancer_subnet_ids}"

    #Optional
    ip_mode = "${var.load_balancer_ip_mode}"
    is_private = "${var.load_balancer_is_private}"
}

resource "oci_load_balancer_backend_set" "test_backend_set" {
    #Required
    health_checker {
        #Required
        protocol = "${var.backend_set_health_checker_protocol}"

        #Optional
        interval_ms = "${var.backend_set_health_checker_interval_ms}"
        port = "${var.backend_set_health_checker_port}"
        response_body_regex = "${var.backend_set_health_checker_response_body_regex}"
        retries = "${var.backend_set_health_checker_retries}"
        return_code = "${var.backend_set_health_checker_return_code}"
        timeout_in_millis = "${var.backend_set_health_checker_timeout_in_millis}"
        url_path = "${var.backend_set_health_checker_url_path}"
    }
    load_balancer_id = "${oci_load_balancer_load_balancer.test_load_balancer.id}"
    name = "${var.backend_set_name}"
    policy = "${var.backend_set_policy}"

    #Optional
    lb_cookie_session_persistence_configuration {

        #Optional
        cookie_name = "${var.backend_set_lb_cookie_session_persistence_configuration_cookie_name}"
        disable_fallback = "${var.backend_set_lb_cookie_session_persistence_configuration_disable_fallback}"
        domain = "${var.backend_set_lb_cookie_session_persistence_configuration_domain}"
        is_http_only = "${var.backend_set_lb_cookie_session_persistence_configuration_is_http_only}"
        is_secure = "${var.backend_set_lb_cookie_session_persistence_configuration_is_secure}"
        max_age_in_seconds = "${var.backend_set_lb_cookie_session_persistence_configuration_max_age_in_seconds}"
        path = "${var.backend_set_lb_cookie_session_persistence_configuration_path}"
    }
    session_persistence_configuration {
        #Required
        cookie_name = "${var.backend_set_session_persistence_configuration_cookie_name}"

        #Optional
        disable_fallback = "${var.backend_set_session_persistence_configuration_disable_fallback}"
    }
    ssl_configuration {
        #Required
        certificate_name = "${oci_load_balancer_certificate.test_certificate.certificate_name}"

    }
}

resource "oci_load_balancer_backend" "test_backend" {
    #Required
    backendset_name = "${oci_load_balancer_backend_set.test_backend_set.name}"
    ip_address = "${var.backend_ip_address}"
    load_balancer_id = "${oci_load_balancer_load_balancer.test_load_balancer.id}"
    port = "${var.backend_port}"

    #Optional
    backup = "${var.backend_backup}"
    drain = "${var.backend_drain}"
    offline = "${var.backend_offline}"
    weight = "${var.backend_weight}"
}

resource "oci_load_balancer_listener" "test_listener" {
    #Required
    default_backend_set_name = "${oci_load_balancer_backend_set.test_backend_set.name}"
    load_balancer_id = "${oci_load_balancer_load_balancer.test_load_balancer.id}"
    name = "${var.listener_name}"
    port = "${var.listener_port}"
    protocol = "${var.listener_protocol}"

    #Optional
    connection_configuration {
        #Required
        idle_timeout_in_seconds = "${var.listener_connection_configuration_idle_timeout_in_seconds}"

        #Optional
        backend_tcp_proxy_protocol_version = "${var.listener_connection_configuration_backend_tcp_proxy_protocol_version}"
    }
    hostname_names = ["${oci_load_balancer_hostname.test_hostname.name}"]
    path_route_set_name = "${oci_load_balancer_path_route_set.test_path_route_set.name}"
    rule_set_names = ["${oci_load_balancer_rule_set.test_rule_set.name}"]
    ssl_configuration {
        #Required
        certificate_name = "${oci_load_balancer_certificate.test_certificate.name}"

    }
}