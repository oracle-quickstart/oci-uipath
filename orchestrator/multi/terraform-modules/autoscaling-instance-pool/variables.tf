variable "compartment_id" {}

variable "availability_domain" {
    default = "MCLg:US-ASHBURN-AD-1"
}

variable "subnet_id" {}

variable "backend_set_name" {}

variable "load_balancer_id" {}

#variable "instance_pool_placement_configurations_fault_domains" {}

#variable "instance_pool_placement_configurations_secondary_vnic_subnets_display_name" {}

variable "instance_pool_size" {
    default = "2"
}

variable "instance_pool_display_name" {
    default = "orchestratorpool"
}

variable "instance_pool_load_balancers_port" {
    default = "443"
}

variable "instance_pool_load_balancers_vnic_selection" {
    default = "PrimaryVnic"
}

# variable "instance_configuration_display_name" {
#     default = "instance_config"
# }

variable "instance_configuration_instance_details_instance_type" {
    default = "compute"
}

variable "instance_configuration_instance_details_launch_details_create_vnic_details_assign_public_ip" {
    default = "true"
}

#variable "instance_configuration_instance_details_launch_details_create_vnic_details_display_name" {}

#variable "instance_configuration_instance_details_launch_details_create_vnic_details_hostname_label" {}

variable "instance_configuration_instance_details_launch_details_create_vnic_details_nsg_ids" {}

#variable "instance_configuration_instance_details_launch_details_create_vnic_details_private_ip" {}

#variable "instance_configuration_instance_details_launch_details_display_name" {}

#variable "instance_configuration_instance_details_launch_details_fault_domain" {}

#TODO add metadata for orch
variable "instance_configuration_instance_details_launch_details_metadata" {
    default = ""
}

variable "instance_configuration_instance_details_launch_details_shape" {
    default = "VM.Standard2.1"
}

variable "instance_configuration_instance_details_launch_details_source_details_source_type" {
    default = "image"
}

variable "instance_configuration_source" {
    default = "NONE"
}

variable "oci_core_instance_id" {
    default = ""
}

variable "image_id" {}

variable "instance_username" {}

variable "instance_password" {}

variable "orchestratorVersion" {}
 
variable "sqlserver" {}

variable "databaseName" {}

variable "databaseType" {}

variable "databaseUserPassword" {}

variable "databaseUserName" {}

variable "passphrase" {}

variable "orchestratorAdminPassword" {}

variable "region" {}

#variable "publicUrl" {}

variable "redisServerHost" {}