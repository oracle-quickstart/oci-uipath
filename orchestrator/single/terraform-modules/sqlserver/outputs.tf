output "sqlserver_hostname" {
  value = oci_core_instance.sqlserver-vm.hostname_label
}

output "sqlserver_private_ip" {
  value = oci_core_instance.sqlserver-vm.private_ip
}
