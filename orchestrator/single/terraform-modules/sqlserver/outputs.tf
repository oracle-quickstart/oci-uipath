output "sqlserver_hostname" {
  value = var.type == "eval" ? oci_core_instance.sqlserver-eval[0].hostname_label : oci_core_instance.sqlserver-standard[0].hostname_label
}

output "sqlserver_private_ip" {
  value = var.type == "eval" ? oci_core_instance.sqlserver-eval[0].private_ip : oci_core_instance.sqlserver-standard[0].private_ip
}
