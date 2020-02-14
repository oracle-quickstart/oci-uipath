variable "instance_username" {
  description = "Default username for OCI is opc"

}
variable "instance_password" {
  description = "Password for local username"
}

## Set Robot local account role : localadmin or localuser
variable "robot_local_account_role" {
  description = "Robot local accout role : localadmin or localuser"
  default     = "localadmin"
}

# UiPath vars

#orchestrator url
variable "orchestrator_url" {
}

#orchestrator tennant
variable "orchestrator_tennant" {
}

#orchestrator admin username
variable "orchestrator_admin" {
}

#orchestrator admin password
variable "orchestrator_adminpw" {
}


#Robot type
variable "robot_type" {
  # "Unattended",
  # "Attended",
  # "Nonproduction",
  # "Development"
}
variable "addRobotToExistingEnvs" {
  description = "Add Robot to all existing environments"
  default     = "No" #Yes
}
