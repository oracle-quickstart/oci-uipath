variable "marketplace_source_images" {
  type = map(object({
    ocid = string
    is_pricing_associated = bool
    compatible_shapes = set(string)
  }))
  default = {
    main_mktpl_image = {
      ocid = "ocid1.image.oc1..aaaaaaaa3en4cf5bmb3yaxk45xd4f7lvsuhje3ggrl63y7k655czwjsiy4nq"
      is_pricing_associated = false
      compatible_shapes = []
    }
  }
}
