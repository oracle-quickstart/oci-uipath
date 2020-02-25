## Allow Ingress HTTPS from 
module "default_vcn_plus_subnet" {
  source              = "./terraform-modules/vcn-plus-subnet-default"
  compartment_ocid    = var.compartment_ocid
  vcn_display_name    = var.vcn_display_name
  vcn_cidr_block      = var.vcn_cidr_block
  vcn_dns_label       = var.vcn_dns_label
  subnet_display_name = var.subnet_display_name
  subnet_cidr_block   = var.subnet_cidr_block
  subnet_dns_label    = var.subnet_dns_label
}

module "default_network_sec_group" {
  source           = "./terraform-modules/network-security-groups"
  compartment_ocid = var.compartment_ocid
  nsg_display_name = var.nsg_display_name
  nsg_whitelist_ip = var.nsg_whitelist_ip
  vcn_id           = module.default_vcn_plus_subnet.vcn_id
  vcn_cidr_block   = var.vcn_cidr_block
}


data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = var.availability_domain_number
}

resource "oci_core_instance" "simple-vm" {
  count               = var.instance_count
  availability_domain = (var.availability_domain_name != "" ? var.availability_domain_name : data.oci_identity_availability_domain.ad.name)
  compartment_id      = var.compartment_ocid
  display_name        = "${var.vm_display_name}${count.index}"
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
   #user_data = "${base64encode(element(data.template_file.uirobot_setup.*.rendered, count.index))}"
   user_data = "${data.template_cloudinit_config.cloudinit_config}"
  }
}

data "template_file" "uirobot_setup" {
  #count ="${var.instance_count}"
  template = base64encode(file("./user_data_uirobot_setup.txt"))
}

data "template_cloudinit_config" "cloudinit_config" {
  gzip          = false
  base64_encode = true

  part {
    filename     = "cloudinit.ps1"
    content_type = "text/x-shellscript"
    content      = "${data.template_file.uirobot_setup.rendered}"
  }

}

output "instance_public_ip" {
  value = oci_core_instance.simple-vm.*.public_ip
}

output "instance_private_ip" {
  value = oci_core_instance.simple-vm.*.private_ip
}

