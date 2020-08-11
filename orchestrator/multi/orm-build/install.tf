variable "save_to" {
    default = ""
}

data "archive_file" "generate_zip" {
  type        = "zip"
  output_path = (var.save_to != "" ? "${var.save_to}/orm.zip" : "${path.module}/dist/orm.zip")
  source_dir = "../"
  excludes    = ["orm-build", "Packer", "terraform.tfstate", "terraform.tfvars.template", "terraform.tfvars", "provider.tf", ".terraform", "terraform.tfstate.backup", "key"]
}
