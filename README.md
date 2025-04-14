# Terraform GCP Network-Peering

[![Opstree Solutions][opstree_avatar]][opstree_homepage]<br/>[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

This Terraform configuration sets up VPC peering and optional reverse peering between multiple Google Cloud networks using dynamic values from var.vpc_peerings. It supports exporting/importing custom routes and subnet routes with public IPs, enabling bidirectional communication across projects or networks.

## Architecture

<img width="6000" length="8000" alt="Terraform" src="https://github.com/user-attachments/assets/26c523f3-290d-4be9-bc8b-39fbca89478b">


## Providers

| Name                                              | Version  |
|---------------------------------------------------|----------|
| <a name="provider_gcp"></a> [gcp](#provider\_gcp) | 6.0   |

## Usage

```hcl
module "vpc_peering" {
  source       = "./module"
  vpc_peerings = var.vpc_peerings

  providers = {
    google.peer = google.peer
  }
}


# Variable values

project_id      = "nw-opstree-dev-landing-zone"
peer_project_id = "nw-opstree-dev-landing-zone" #

vpc_peerings = {
  "peering_1" = {
    name                 = "peer-vpc1-vpc2"
    network              = "default"
    peer_network         = "new-vpc"
    project_id           = "nw-opstree-dev-landing-zone"
    peer_project_id      = "nw-opstree-dev-landing-zone"
    export_custom_routes = false
    import_custom_routes = false
  }

  "peering_2" = {
    name                                = "peer-vpc3-vpc4"
    project_id                          = "nw-opstree-dev-landing-zone"
    network                             = "default"
    peer_project_id                     = "service-project-tf-demo" 
    peer_network                        = "new-vpc"
    export_custom_routes                = false
    import_custom_routes                = false
    export_subnet_routes_with_public_ip = true
    import_subnet_routes_with_public_ip = false
  }
}


```

## Inputs

| Name | Description | Type | Default | Required | 
|------|-------------|:----:|---------|:--------:|
|**project_id**| The ID of the project for which the IAM resource is to be configured | string |{ } | yes| 
|**peer_project_ids**| The peer project ID for cross-project VPC peering | string | { } | yes | 
|**vpc_peerings**| Map of VPC peerings | map(object) | [ ] |yes| 
 

## Outputs
| Name | Description |
|------|-------------|
|**vpc_peering_connections**| List of VPC peering connections created| 
|**reverse_peering_connections**| List of reverse VPC peering connections created|                                           
