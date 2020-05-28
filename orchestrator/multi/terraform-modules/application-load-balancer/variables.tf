variable "compartment_id" {
}

variable "load_balancer_display_name" {
}

variable "load_balancer_shape" {
}

variable "load_balancer_subnet_ids" {
}

variable "backend_set_health_checker_protocol" {
}

variable "backend_set_health_checker_interval_ms" {
}

variable "backend_set_health_checker_port" {
}

variable "backend_set_health_checker_response_body_regex" {
}

variable "backend_set_health_checker_retries" {
}

variable "backend_set_health_checker_return_code" {
}

variable "backend_set_health_checker_timeout_in_millis" {
}

variable "backend_set_health_checker_url_path" {
}

variable "backend_set_name" {
}

variable "backend_set_policy" {
}

variable "backend_set_lb_cookie_session_persistence_configuration_cookie_name" {
}

variable "backend_set_lb_cookie_session_persistence_configuration_disable_fallback" {
}

variable "backend_set_lb_cookie_session_persistence_configuration_domain" {
}

variable "backend_set_lb_cookie_session_persistence_configuration_is_http_only" {
}

variable "backend_set_lb_cookie_session_persistence_configuration_is_secure" {
}

variable "backend_set_lb_cookie_session_persistence_configuration_max_age_in_seconds" {
}

variable "backend_set_lb_cookie_session_persistence_configuration_path" {
}

variable "backend_set_session_persistence_configuration_cookie_name" {
}

variable "backend_set_session_persistence_configuration_disable_fallback" {
}

variable "backend_ip_address" {
}

variable "backend_port" {
}

variable "backend_backup" {
}

variable "backend_drain" {
}

variable "backend_offline" {
}

variable "backend_weight" {
}

variable "listener_name" {
}

variable "listener_port" {
}

variable "listener_protocol" {
}

variable "listener_connection_configuration_idle_timeout_in_seconds" {
}

#Required when protocol = TCP
variable "listener_connection_configuration_backend_tcp_proxy_protocol_version" {
    default = 1
}

variable "" {
}

variable "" {
}