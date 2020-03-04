# VCN comes with default route table, security list and DHCP options

resource "oci_core_vcn" "vcn" {
  count          = var.network_strategy == "Use Existing VCN and Subnet" ? 0:1
  dns_label      = var.vcn_dns_label
  cidr_block     = var.vcn_cidr_block
  compartment_id = var.compartment_ocid
  display_name   = var.vcn_display_name
}

resource "oci_core_internet_gateway" "igw" {
  count          = var.network_strategy == "Use Existing VCN and Subnet" ? 0:1
  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_id
}

resource "oci_core_default_route_table" "default_route_table" {
  count                      = var.network_strategy == "Use Existing VCN and Subnet" ? 0:1
  manage_default_resource_id = oci_core_vcn.vcn[count.index].default_route_table_id

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw[count.index].id
  }
}

resource "oci_core_subnet" "public_subnet" {
  count                      = var.network_strategy == "Use Existing VCN and Subnet" ? 0:1
  compartment_id             = var.compartment_ocid
  vcn_id                     = var.vcn_id
  cidr_block                 = var.subnet_cidr_block
  display_name               = var.subnet_display_name
  dns_label                  = var.subnet_dns_label[count.index]
  route_table_id             = oci_core_vcn.vcn[count.index].default_route_table_id
  prohibit_public_ip_on_vnic = "false"
}

data "oci_core_vcn" "existing_vcn" {
    vcn_id = var.vcn_id
}

data "oci_core_subnet" "existing_subnet" {
    subnet_id = var.subnet_id
}