output "test_backend_set_name"{
    value = "${oci_load_balancer_backend_set.test_backend_set.name}"
}

output "test_load_balancer_id" {
    value = "${oci_load_balancer_load_balancer.test_load_balancer.id}"
}

# output "test_certificate_name" {
#     value = "${oci_load_balancer_certificate.test_certificate.certificate_name}"
# }

output "load_balancer_public_ip" {
    value = join("", oci_load_balancer_load_balancer.test_load_balancer.ip_address_details.*.ip_address)
}