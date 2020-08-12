variable "compartment_id" {
    default = "ocid1.tenancy.oc1..aaaaaaaa4qmyu4ddxfuvdeqpe5rm6vwgye4iolxvmzyqicmzfc5zmvpcua3q"
}

variable "load_balancer_display_name" {
    default = "orchlb"
}

variable "load_balancer_shape" {
    default = "100Mbps"
}

variable "load_balancer_subnet_ids" {}

variable "load_balancer_ip_mode" {
    default = "IPV4"
}

variable "load_balancer_is_private" {
    default = "false"
}

variable "load_balancer_network_security_group_ids" {}
 

# variable "certificate_certificate_name" {}

# variable "certificate_private_key" {}

# variable "certificate_public_certificate" {}

# variable "ca_certificate" {}

variable "certificate_passphrase" {
  default = "1234"
}


variable "backend_set_health_checker_protocol" {
    default = "HTTP"
}

variable "backend_set_health_checker_interval_ms" {
    default = "30000"
}

#TODO Change checbackend_set_health_checker_port to 443
variable "backend_set_health_checker_port" {
    default = "443"
}

variable "backend_set_name" {
    default = "backendset"
}

variable "backend_set_policy" {
    default = "LEAST_CONNECTIONS"
}

variable "listener_name" {
  default = "lblistener"
}

variable "listener_port" {
  default = "443"
}


variable "listener_protocol" {
  default = "HTTP"
}

variable "listener_connection_configuration_idle_timeout_in_seconds" {
  default = "60"
}

#Required when protocol = TCP
variable "listener_connection_configuration_backend_tcp_proxy_protocol_version" {
  default = 1
}

# variable "backend_set_health_checker_response_body_regex" {
# }

variable "backend_set_health_checker_retries" {
  default = 3
}

variable "backend_set_health_checker_return_code" {
  default = 200
}

variable "backend_set_health_checker_timeout_in_millis" {
  default = 3000
}

variable "backend_set_health_checker_url_path" {
  default = "/api/status"
}

# variable "backend_set_lb_cookie_session_persistence_configuration_cookie_name" {
# }

# variable "backend_set_lb_cookie_session_persistence_configuration_disable_fallback" {
# }

# variable "backend_set_lb_cookie_session_persistence_configuration_domain" {
# }

# variable "backend_set_lb_cookie_session_persistence_configuration_is_http_only" {
# }

# variable "backend_set_lb_cookie_session_persistence_configuration_is_secure" {
# }

# variable "backend_set_lb_cookie_session_persistence_configuration_max_age_in_seconds" {
# }

# variable "backend_set_lb_cookie_session_persistence_configuration_path" {
# }

# variable "backend_set_session_persistence_configuration_cookie_name" {
# }

# variable "backend_set_session_persistence_configuration_disable_fallback" {
#}

# variable "backend_ip_address" {
# }

# variable "backend_port" {
# }

# variable "backend_backup" {
# }

# variable "backend_drain" {
# }

# variable "backend_offline" {
# }

# variable "backend_weight" {
# }