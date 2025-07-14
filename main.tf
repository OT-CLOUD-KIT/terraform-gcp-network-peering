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

  network      = var.network
  peer_network = var.peer_network

  export_custom_routes                = lookup(each.value, "export_custom_routes", false)
  import_custom_routes                = lookup(each.value, "import_custom_routes", false)
  export_subnet_routes_with_public_ip = lookup(each.value, "export_subnet_routes_with_public_ip", false)
  import_subnet_routes_with_public_ip = lookup(each.value, "import_subnet_routes_with_public_ip", false)
}

resource "google_compute_network_peering" "reverse-peering" {
  for_each = var.vpc_peerings

  name = "${each.value.name}-reverse"

  network      = var.peer_network
  peer_network = var.network

  export_custom_routes                = lookup(each.value, "import_custom_routes", false)
  import_custom_routes                = lookup(each.value, "export_custom_routes", false)
  export_subnet_routes_with_public_ip = lookup(each.value, "import_subnet_routes_with_public_ip", false)
  import_subnet_routes_with_public_ip = lookup(each.value, "export_subnet_routes_with_public_ip", false)
}
