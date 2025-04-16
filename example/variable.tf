variable "project_id" {
  description = "The default project ID where resources will be created"
  type        = string
}

variable "peer_project_id" {
  description = "The peer project ID for cross-project VPC peering"
  type        = string
}

variable "vpc_peerings" {
  description = "Map of VPC peerings"
  type = map(object({
    name                                = string
    network                             = string
    peer_network                        = string
    project_id                          = string
    peer_project_id                     = string
    export_custom_routes                = optional(bool)
    import_custom_routes                = optional(bool)
    export_subnet_routes_with_public_ip = optional(bool)
    import_subnet_routes_with_public_ip = optional(bool)
  }))
}
