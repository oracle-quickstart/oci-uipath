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
  mp_listing_id               = var.sql_mp_listing_id
  mp_listing_resource_id      = var.sql_mp_listing_resource_id
  mp_listing_resource_version = var.sql_mp_listing_resource_version

}

resource "oci_core_instance" "sqlserver-vm" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = "sqlserver"
  shape               = var.vm_compute_shape
  count               = var.type == "eval" ? 1 : 0

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
        "export MSSQL_SA_PASSWORD='${var.mssql_sa_password}'",
        file("${path.module}/scripts/sqlserver.sh")
      ],
    ))
  }

}


resource "oci_core_instance" "sqlserver-standard" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = "sqlserver-standard"
  shape               = var.vm_compute_shape
  count               = var.type == "paid" ? 1 : 0

  create_vnic_details {
    subnet_id        = var.subnet_id
    display_name     = "sqlserver-standard"
    hostname_label   = "sqlserver"
    assign_public_ip = true
    nsg_ids          = [var.nsg_id]
  }

  source_details {
    source_type = "image"
    source_id   = local.mp_listing_resource_id
  }

}


###
# subscription resources for optional paid SQL server listing
###

#Get Image Agreement
resource "oci_core_app_catalog_listing_resource_version_agreement" "mp_image_agreement" {
  count = var.type == "paid" ? 1 : 0

  listing_id               = local.mp_listing_id
  listing_resource_version = local.mp_listing_resource_version
}

#Accept Terms and Subscribe to the image, placing the image in a particular compartment
resource "oci_core_app_catalog_subscription" "mp_image_subscription" {
  count                    = var.type == "paid" ? 1 : 0
  compartment_id           = var.compartment_ocid
  eula_link                = oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement[0].eula_link
  listing_id               = oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement[0].listing_id
  listing_resource_version = oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement[0].listing_resource_version
  oracle_terms_of_use_link = oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement[0].oracle_terms_of_use_link
  signature                = oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement[0].signature
  time_retrieved           = oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement[0].time_retrieved

  timeouts {
    create = "20m"
  }
}

# Gets the partner image subscription
data "oci_core_app_catalog_subscriptions" "mp_image_subscription" {
  #Required
  compartment_id = var.compartment_ocid

  #Optional
  listing_id = local.mp_listing_id

  filter {
    name = "listing_resource_version"
    values = [local.mp_listing_resource_version]
  }
}
