#Variables declared in this file must be declared in the marketplace.yaml

############################
#  Hidden Variable Group   #
############################
variable "tenancy_ocid" {
}

# variable "mp_listing_id"{
# }

variable "mp_listing_resource_id" {
  default     = "ocid1.image.oc1.iad.aaaaaaaarpliejzt7zjzgdp7tnkyl6pkfxu2bdpx6w2diy6x3vcc7736o6lq"
  description = "Marketplace - Image OCID"
}

variable "mp_listing_resource_version" {
}


############################
#  Marketplace Image      #
############################


# variable "mp_listing_resource_id" {
#   default = "ocid1.image.oc1.iad.aaaaaaaamvqqg42veexxstidctjf4gw76dlbqxpnew5jwbm4lz4jghvtn47a"
#   description = "Marketplace - Image OCID"
# }

############################
#  Basics Configuration   #
############################

variable "vm_display_name" {
  description = "Instance Name"
  default     = "TestRobot"
}

variable "instance_username" {
  description = "Default username for OCI is opc"
}

variable "instance_password" {
  description = "Password for local username"
}


variable "instance_count" {
  description = "Number of VMs"
  default     = 1
}

variable "region" {
  type = string
}

variable "compartment_ocid" {
  description = "Compartment where infrastructure resources will be created"
}


############################
#  Orchestrator Connection Info   #
############################

variable "orchestrator_url" {
}
variable "orchestrator_admin" {
}

variable "orchestrator_adminpw" {
}

variable "orchestrator_tennant" {
}

variable "robot_type" {
}

variable "robot_version" {
}

variable "addRobotToExistingEnvs" {
}


############################
#  Virtual Machine Settings   #
############################

variable "vm_compute_shape" {
  default = "VM.Standard2.4"
  description = "Compute Shape"
}

variable "availability_domain_name" {
  default     = ""
  description = "Availability Domain"
}

variable "network_strategy" {
  default = "Create New VCN and Subnet"
}

variable "vcn_id" {
  default = ""
}

variable "vcn_display_name" {
  default = "uipath"
  description = "VCN Name"
}

variable "vcn_dns_label" {
  default = "uipath"
}

variable "subnet_dns_label" {
  default = "subnet"
}

variable "vcn_cidr_block" {
  description = "VCN CIDR"
  default     = "10.0.0.0/16"
}

variable "subnet_id" {
  default = ""
}

variable "subnet_display_name" {
  description = "Subnet Name"
  default     = "subnet"
}

variable "subnet_cidr_block" {
  description = "Subnet CIDR"
  default     = "10.0.0.0/24"
}
variable "nsg_display_name" {
  default = ""
}

variable "nsg_whitelist_ip" {
  default = ""
}
