#Variables declared in this file must be declared in the marketplace.yaml

############################
#  Hidden Variable Group   #
############################
variable "tenancy_ocid" {
}

variable "mp_listing_id"{
 default = "ocid1.appcataloglisting.oc1..aaaaaaaari5mnh7pqope3kur7op5xvvt7wappxzqd2vm42u2ygmyfnxt7fzq"
}

variable "mp_listing_resource_id" {
  default     = "ocid1.image.oc1..aaaaaaaawq2a6pwmu33ro54ct6xsi7f7nyvya5n36rhod6p5prdr2za25eiq"
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
  default     = "Orchestrator"
}

variable "instance_username" {
  description = "Default username for OCI is opc"
}

variable "instance_password" {
  description = "Password for local username"
}

variable "region" {
  type = string
}

variable "compartment_ocid" {
  description = "Compartment where infrastructure resources will be created"
}


############################
#  Orchestrator Info   #
############################

variable "orchestratorVersion" {
}

variable "orchestratorAdminPassword" {
}

variable "passphrase" {
}

# db variables passed to/used by orchestrator in SQL section



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

############################
#  SQL settings   #
############################
variable "databaseType" {
  # Understood values: "New SQL Server Evaluation", "Existing SQL Server", "New Paid SQL Server Standard"
  # WARNING: paid option incurs a license charge beyond IaaS cost. See: https://console.us-ashburn-1.oraclecloud.com/marketplace/application/60874068/overview
  default = "New SQL Server Evaluation"
}
variable "databaseServerName" {
  # placeholder value required for ORM, change based on databaseType
  default = "sqlserver.domain.com"
}

variable "databaseName" {
  # placeholder value required for ORM, change based on databaseType
  default = "uipath"
}

variable "databaseUserName" {
  # placeholder value required for ORM, change based on databaseType
  default = "SA"
}

variable "databaseUserPassword" {
}

variable "ssh_public_key"{
  # Used only for SQL Server evaluation running on OL instance
}
