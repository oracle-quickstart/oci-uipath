
locals {
  use_existing_network = var.network_strategy == "Use Existing VCN and Subnet" ? true : false
  sqlserver            = (var.databaseType == "New SQL Server Evaluation" || var.databaseType == "New Paid SQL Server Standard") ? module.sqlserver.sqlserver_private_ip : var.databaseServerName
}

module "default_vcn_plus_subnet" {
  source               = "./terraform-modules/vcn-plus-subnet-default"
  compartment_ocid     = var.compartment_ocid
  use_existing_network = local.use_existing_network
  vcn_id               = local.use_existing_network ? var.vcn_id : ""
  subnet_id            = local.use_existing_network ? var.subnet_id : ""
  vcn_display_name     = var.vcn_display_name
  vcn_cidr_block       = var.vcn_cidr_block
  vcn_dns_label        = var.vcn_dns_label
  subnet_display_name  = var.subnet_display_name
  subnet_cidr_block    = var.subnet_cidr_block
  subnet_dns_label     = var.subnet_dns_label
}

module "default_network_sec_group" {
  source           = "./terraform-modules/network-security-groups"
  compartment_ocid = var.compartment_ocid
  nsg_display_name = var.nsg_display_name
  nsg_whitelist_ip = var.nsg_whitelist_ip
  vcn_id           = module.default_vcn_plus_subnet.vcn_id
  vcn_cidr_block   = var.vcn_cidr_block
}

resource "oci_core_instance" "orch-single-instance" {
  availability_domain = var.availability_domain_name
  compartment_id      = var.compartment_ocid
  display_name        = var.vm_display_name
  shape               = var.vm_compute_shape

  create_vnic_details {
    subnet_id        = module.default_vcn_plus_subnet.subnet_id
    display_name     = var.vm_display_name
    assign_public_ip = true
    nsg_ids          = [module.default_network_sec_group.nsg_id]
  }

  source_details {
    source_type = "image"
    source_id   = var.mp_listing_resource_id
  }

  metadata = {
    user_data = data.template_cloudinit_config.cloudinit_config.rendered
  }

  depends_on = [
    module.sqlserver
  ]
}

data "template_file" "orchestrator_setup" {
  template = file("./user_data.txt")
  vars = {
    instance_username         = var.instance_username
    instance_password         = var.instance_password
    orchestratorVersion       = var.orchestratorVersion
    orchestratorFolder        = "C:\\Program Files\\UiPath\\Orchestrator"
    databaseServerName        = local.sqlserver
    databaseName              = var.databaseName
    databaseUserName          = (var.databaseType == "New Paid SQL Server Standard") ? "uipath" : var.databaseUserName
    databaseUserPassword      = var.databaseUserPassword
    passphrase                = var.passphrase
    orchestratorAdminPassword = var.orchestratorAdminPassword
    certificateBase64         = var.certificateBase64
    certificatePass           = var.certificatePass
    ISCertificateBase64       = var.ISCertificateBase64
    ISCertificatePass         = var.ISCertificatePass
  }
}

data "template_cloudinit_config" "cloudinit_config" {
  gzip          = false
  base64_encode = true

  part {
    filename     = "cloudinit.ps1"
    content_type = "text/x-shellscript"
    content      = data.template_file.orchestrator_setup.rendered
  }

}

module "sqlserver" {
  source              = "./terraform-modules/sqlserver"
  compartment_ocid    = var.compartment_ocid
  vm_compute_shape    = "VM.Standard2.2"
  subnet_id           = module.default_vcn_plus_subnet.subnet_id
  availability_domain = var.availability_domain_name
  ssh_public_key      = var.ssh_public_key
  mssql_sa_password   = var.databaseUserPassword
  nsg_id              = module.default_network_sec_group.nsg_id
  password            = var.orchestratorAdminPassword
  type                = var.databaseType == "New SQL Server Evaluation" ? "eval" : "paid"
}

output "orchestrator_url" {
  value = join("", ["https://", oci_core_instance.orch-single-instance.public_ip])
}

output "orchestrator_public_ip" {
  value = oci_core_instance.orch-single-instance.public_ip
}

output "orchestrator_private_ip" {
  value = oci_core_instance.orch-single-instance.private_ip
}

output "sqlserver_hostname" {
  value = module.sqlserver.sqlserver_hostname
}

output "sqlserver_private_ip" {
  value = module.sqlserver.sqlserver_private_ip
}
