project_id      = "landing-zone"
peer_project_id = "nw-landing-zone" #

vpc_peerings = {
  "peering_1" = {
    name                 = "peer-vpc1-vpc2"
    project_id           = "landing-zone"
    peer_project_id      = "nw-landing-zone"
    export_custom_routes = false
    import_custom_routes = false
  }

  "peering_2" = {
    name                                = "peer-vpc3-vpc4"
    project_id                          = "landing-zone"
    peer_project_id                     = "service-project-tf-demo" 
    export_custom_routes                = false
    import_custom_routes                = false
    export_subnet_routes_with_public_ip = true
    import_subnet_routes_with_public_ip = false
  }
}

network              = "default"

peer_network         = "new-vpc"
