locals {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaa4qmyu4ddxfuvdeqpe5rm6vwgye4iolxvmzyqicmzfc5zmvpcua3q"
  subnet_id      = "ocid1.subnet.oc1.iad.aaaaaaaaugo7fj3ptfuvtygsmyazdl5wpps4e5lqj375o3yi7xn3i4hvnrga"
  #TODO Win 2019Standard imageID 
  # image_id       = "ocid1.image.oc1.iad.aaaaaaaa624xkczbwzgrvquhmmtre7r7mxmse2g6es7rcit5vt2bhpyoy4ha"
  #TODO Win 2016Standard imageID
  image_id = "ocid1.image.oc1.iad.aaaaaaaa4yfz2m4c7d4rvwbljam66la7z5yzalvactgbikn6on6vxoj6woha"
  #TODO de-comment line 6,7 and delete lines 8,9
  # use_existing_network = var.network_strategy == "Use Existing VCN and Subnet" ? true : false
  # sqlserver            = (var.databaseType == "New SQL Server Evaluation" || var.databaseType == "New Paid SQL Server Standard") ? module.sqlserver.sqlserver_private_ip : var.databaseServerName
  use_existing_network = false
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

# resource "oci_core_instance" "orch-single-instance" {
#   availability_domain = var.availability_domain_name
#   compartment_id      = var.compartment_ocid
#   display_name        = var.vm_display_name
#   shape               = var.vm_compute_shape

#   create_vnic_details {
#     subnet_id        = module.default_vcn_plus_subnet.subnet_id
#     display_name     = var.vm_display_name
#     assign_public_ip = true
#     nsg_ids          = [module.default_network_sec_group.nsg_id]
#   }

#   source_details {
#     source_type = "image"
#     source_id   = var.mp_listing_resource_id
#   }

#   metadata = {
#     user_data = data.template_cloudinit_config.cloudinit_config.rendered
#   }

#   depends_on = [
#     module.sqlserver
#   ]
#TODO move publicUrl to autoscaling_group module below for 20.4 OR version
#publicUrl                                                                          = join("", ["https://", module.lb.load_balancer_public_ip])
# }

module "autoscaling_group" {
  source                                                                             = "./terraform-modules/autoscaling-instance-pool"
  #pool_depends_on                                                                    = module.file_storage.file_storage_export_id
  compartment_id                                                                     = local.compartment_id
  backend_set_name                                                                   = module.lb.test_backend_set_name
  load_balancer_id                                                                   = module.lb.test_load_balancer_id
  subnet_id                                                                          = module.default_vcn_plus_subnet.subnet_id
  instance_configuration_instance_details_launch_details_create_vnic_details_nsg_ids = module.default_network_sec_group.nsg_id
  image_id                                                                           = local.image_id
  instance_username                                                                  = var.instance_username
  instance_password                                                                  = var.instance_password
  orchestratorVersion                                                                = var.orchestratorVersion
  sqlserver                                                                          = module.sqlserver.sqlserver_private_ip
  databaseName                                                                       = var.databaseName
  databaseType                                                                       = var.databaseType
  databaseUserName                                                                   = var.databaseUserName
  databaseUserPassword                                                               = var.databaseUserPassword
  passphrase                                                                         = var.passphrase
  orchestratorAdminPassword                                                          = var.orchestratorAdminPassword
  region                                                                             = var.region
  redisServerHost                                                                    = var.redisServerHost
  mount_target_ip                                                                    = data.oci_core_private_ip.mount_target_ip.ip_address
  # nuget_path                                                                         = module.file_storage.path_to_nuget
  nuget_path                                                                         = var.export_path
  user_ocid                                                                          = var.user_ocid
  fingerprint                                                                        = var.fingerprint
  key_file                                                                           = var.key_file
  tenancy                                                                            = var.tenancy_ocid
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

module "lb" {
  source                         = "./terraform-modules/application-load-balancer"
  compartment_id                 = local.compartment_id
  load_balancer_display_name     = var.load_balancer_display_name
  # certificate_certificate_name   = var.certificate_name
  # certificate_private_key        = var.cert_private_key
  # certificate_public_certificate = var.cert_public_key
  # ca_certificate                 = var.ca_certificate
  load_balancer_subnet_ids       = [module.default_vcn_plus_subnet.subnet_id]
  load_balancer_network_security_group_ids = [module.default_network_sec_group.nsg_id]

}

module "file_storage" {
  source = "./terraform-modules/file-storage"
  file_system_availability_domain = var.availability_domain_name
  compartment_id = local.compartment_id
  file_system_display_name = var.file_system_display_name
  mount_target_availability_domain = var.availability_domain_name
  mount_target_subnet =  module.default_vcn_plus_subnet.subnet_id
  mount_target_display_name = var.mount_target_display_name
  export_path = var.export_path
  export_export_options_source = var.export_source
  export_export_options_access = var.export_access
  export_export_options_identity_squash = var.export_identity_squash
  export_export_options_require_privileged_source_port = var.privileged_source_port
}

data "oci_core_private_ip" "mount_target_ip" {
    #Required
    private_ip_id = join("", module.file_storage.mount_target_private_ip_ids)
}
