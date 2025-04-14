terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      configuration_aliases = [
        google.peer
      ]
    }
  }
}

resource "google_compute_network_peering" "peering-1" {
  for_each = var.vpc_peerings

  name = each.value.name

  network      = "projects/${each.value.project_id}/global/networks/${each.value.network}"
  peer_network = "projects/${each.value.peer_project_id}/global/networks/${each.value.peer_network}"

  export_custom_routes                = lookup(each.value, "export_custom_routes", false)
  import_custom_routes                = lookup(each.value, "import_custom_routes", false)
  export_subnet_routes_with_public_ip = lookup(each.value, "export_subnet_routes_with_public_ip", false)
  import_subnet_routes_with_public_ip = lookup(each.value, "import_subnet_routes_with_public_ip", false)
}

resource "google_compute_network_peering" "reverse-peering" {
  for_each = var.vpc_peerings

  name = "${each.value.name}-reverse"

  network      = "projects/${each.value.peer_project_id}/global/networks/${each.value.peer_network}"
  peer_network = "projects/${each.value.project_id}/global/networks/${each.value.network}"

  export_custom_routes                = lookup(each.value, "import_custom_routes", false)
  import_custom_routes                = lookup(each.value, "export_custom_routes", false)
  export_subnet_routes_with_public_ip = lookup(each.value, "import_subnet_routes_with_public_ip", false)
  import_subnet_routes_with_public_ip = lookup(each.value, "export_subnet_routes_with_public_ip", false)
}
