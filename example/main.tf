module "vpc_peering" {
  source       = "./module"
  vpc_peerings = var.vpc_peerings

  providers = {
    google.peer = google.peer
  }
}
