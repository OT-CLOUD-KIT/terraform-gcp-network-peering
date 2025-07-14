variable "vpc_peerings" {
  description = "Map of VPC peerings"
  type = map(object({
    name                                = string
    project_id                          = string
    peer_project_id                     = string
    export_custom_routes                = optional(bool)
    import_custom_routes                = optional(bool)
    export_subnet_routes_with_public_ip = optional(bool)
    import_subnet_routes_with_public_ip = optional(bool)
  }))
}


variable "network" {
  type = string
}

variable "peer_network" {
  type = string
}
