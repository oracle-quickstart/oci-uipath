terraform {
  required_version = "~> 0.12"
}

provider "oci" {
  #TODO de-comment line 28-30, 32-34
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region  = var.region
  version = "~> 3.88"
}

# Variables required by the OCI Provider only when running Terraform CLI with standard user based Authentication
variable "user_ocid" {
    default = "ocid1.user.oc1..aaaaaaaadnaknn6gqenulbqjwp3i4ku4ewmc272vjcs5nz2gs5ows2rd7wnq"
}

variable "fingerprint" {
    default = "e9:cc:e6:54:51:20:e3:e4:0c:9c:9b:76:79:bf:0b:31"
}
#"C:\\Users\\adrian.tudoran\\Documents\\UiPath\\Marketplace\\Oracle\\oci-uipath\\UiPath Robot\\Development\\simple\\key\\oci_key.pem"
variable "private_key_path" {
    default = "C:\\Users\\adrian.tudoran\\UiPath\\Marketplace\\Oracle\\haa\\oci_haa.pem"
}

variable "tenancy_ocid" {
  default = "ocid1.tenancy.oc1..aaaaaaaa4qmyu4ddxfuvdeqpe5rm6vwgye4iolxvmzyqicmzfc5zmvpcua3q"
}

# variable "region" {
#   default = "us-ashburn-1"
# }