variable "instance_username" {
  description = "Default username for OCI is opc"
  default     = "opc"

}
variable "instance_password" {
  description = "Password for local username"
  default     = "1qazXSW@3edc"
}

## Set Robot local account role : localadmin or localuser
variable "robot_local_account_role" {
  description = "Robot local accout role : localadmin or localuser"
  default     = "localadmin"
}

# UiPath vars

#orchestrator url
variable "orchestrator_url" {
  default = "https://robot2orch1910-2bftlnpvxvywa.azurewebsites.net/"
}

#orchestrator tennant
variable "orchestrator_tennant" {
  default = "default"
}

#orchestrator admin username
variable "orchestrator_admin" {
  default = "admin"
}

#orchestrator admin password
variable "orchestrator_adminpw" {
  default = "1qazXSW@3edc"
}


#Robot type
variable "robot_type" {
  # "Unattended",
  # "Attended",
  # "Nonproduction",
  # "Development"
  default = "Unattended"
}
variable "addRobotToExistingEnvs" {
  description = "Add Robot to all existing environments"
  default     = "No" #Yes
}
