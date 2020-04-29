output "sqlserver_hostname" {
  value = oci_core_instance.sqlserver-vm[0].hostname_label
}

output "sqlserver_private_ip" {
  value = oci_core_instance.sqlserver-vm[0].private_ip
}
