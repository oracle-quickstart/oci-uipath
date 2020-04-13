
locals {
  use_existing_network = var.network_strategy == "Use Existing VCN and Subnet" ? true : false
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
  display_name        = "${var.vm_display_name}"
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
}

data "template_file" "orchestrator_setup" {
  template = file("./orchestrator/single/user_data.txt")
  vars = {
    orchestratorVersion         = var.orchestratorVersion
    orchestratorFolder          = var.orchestratorFolder
    databaseServerName          = var.databaseServerName
    databaseName                = var.databaseName
    databaseUserName            = var.databaseUserName
    databaseUserPassword        = var.databaseUserPassword
    databaseAuthenticationMode  = var.databaseAuthenticationMode
    appPoolIdentityType         = var.appPoolIdentityType
    appPoolIdentityUser         = var.appPoolIdentityUser
    appPoolIdentityUserPassword = var.appPoolIdentityUserPassword
    orchestratorAdminPassword   = var.orchestratorAdminPassword

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

output "instance_public_ip" {
  value = oci_core_instance.simple-vm.public_ip
}

output "instance_private_ip" {
  value = oci_core_instance.simple-vm.private_ip
}
