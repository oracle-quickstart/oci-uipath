#Variables declared in this file must be declared in the marketplace.yaml

############################
#  Hidden Variable Group   #
############################
variable "tenancy_ocid" {
}

variable "mp_listing_id" {
  default = "ocid1.appcataloglisting.oc1..aaaaaaaari5mnh7pqope3kur7op5xvvt7wappxzqd2vm42u2ygmyfnxt7fzq"
}

variable "mp_listing_resource_id" {
  default     = "ocid1.image.oc1.iad.aaaaaaaar32ruyuz57xihpizg6he7ae24ma33iuz523q2l2xainewpkb5dyq"
  description = "Marketplace - Image OCID"
}

variable "mp_listing_resource_version" {
  default = "1.0-031820200437"
}

variable "use_marketplace_image" {
  default = true
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

variable "orchestrator_url" {}

variable "orchestrator_admin" {}

variable "orchestrator_adminpw" {}

variable "orchestrator_tennant" {}

variable "robot_type" {}

variable "robot_version" {}

variable "is_orchestrator_certificate_trusted" {}

variable "orchCertificateBase64" {}

variable "orchCertificatePass" {}

variable "is_orchestrator_dns_resolvable" {}

variable "orchestratorIP" {}

variable "orchestratorHostname" {}


############################
#  Virtual Machine Settings   #
############################

variable "vm_compute_shape" {
  default     = "VM.Standard2.2"
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
  default     = "uipath"
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
