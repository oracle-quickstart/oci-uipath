variable "compartment_ocid" {}
variable "ssh_public_key" {}
variable "vm_compute_shape" {}
variable "subnet_id" {}
variable "availability_domain" {}
variable "mssql_sa_password" {}
variable "nsg_id" {}
variable "type" {}
variable sql_mp_listing_id {
  default = "ocid1.appcataloglisting.oc1..aaaaaaaadyirdzoiwya4wt3hqnviqpr4xxhjkm6vzqjd36h2vaoscvwitara"
}
variable sql_mp_listing_resource_id {
  default = "ocid1.image.oc1..aaaaaaaa2zorsxjollcjdq26qijxozek64wv3gvdqf3civlbfwgmc5tpev3a"
}
variable sql_mp_listing_resource_version {
  default = "Microsoft_SQL_2016_Standard_13.0.5366.0-080620192239"
}
