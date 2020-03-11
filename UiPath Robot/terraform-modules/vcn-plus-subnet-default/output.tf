output "existing_vcn_id" {
  value = data.oci_core_vcn.existing_vcn.id
}

output "existing_subnet_id" {
  value = data.oci_core_subnet.existing_subnet.id
}

output "existing_vcn_cidr_block" {
  value = data.oci_core_vcn.existing_vcn.cidr_block
}

output "vcn_id" {
  description = "ocid of created VCN. "
  value       = "${oci_core_vcn.vcn.*.id}"
}

output "subnet_id" {
  description = "ocid of subnet ids. "
  value       = "${join("", oci_core_subnet.public_subnet.*.id)}"
}

output "vcn_cidr_block" {
  description = "cidr block"
  value       = "${oci_core_vcn.vcn.*.cidr_block}"
}

output "default_route_table_id" {
  description = "ocid of default route table. "
  value       = "${oci_core_default_route_table.default_route_table.*.id}"
}

output "internet_gateway_id" {
  description = "ocid of internet gateway. "
  value       = "${oci_core_internet_gateway.igw.*.id}"
}