module "vpc_peering" {
  source       = "./module"
  vpc_peerings = var.vpc_peerings
  network      = var,network
  peer_network = var.peer_network

  providers = {
    google.peer = google.peer
  }
}
