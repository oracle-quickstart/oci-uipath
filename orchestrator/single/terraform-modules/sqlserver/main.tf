data "oci_core_images" "ol7" {
  compartment_id      = "${var.compartment_ocid}"
  operating_system    = "Oracle Linux"
  sort_by             = "TIMECREATED"
  sort_order          = "DESC"
  state               = "AVAILABLE"

  # filter restricts to pegged version regardless of region
  filter {
    name = "display_name"
    values = ["Oracle-Linux-7.7-2020.03.23-0"]
    regex = false
  }

  # filter restricts to OL 7
  filter {
    name = "operating_system_version"
    values = ["7\\.[0-9]"]
    regex = true
  }
}

locals {
  # Platform OL7 image regarless of region
  platform_image = data.oci_core_images.ol7.images[0].id
}

resource "oci_core_instance" "sqlserver-vm" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = "sqlserver"
  shape               = var.vm_compute_shape

  create_vnic_details {
    subnet_id        = var.subnet_id
    display_name     = "sqlserver"
    assign_public_ip = true
    hostname_label = "sqlserver"
    nsg_ids = [var.nsg_id]
  }

  source_details {
    source_type = "image"
    source_id   = local.platform_image
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data = base64encode(join(
      "\n",
      [
        "#!/usr/bin/env bash",
        "export MSSQL_SA_PASSWORD=${var.mssql_sa_password}",
        file("${path.module}/scripts/sqlserver.sh")
      ],
    ))
  }

}
