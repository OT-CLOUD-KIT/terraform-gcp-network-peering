output "vpc_peering_connections" {
  value = { for k, v in google_compute_network_peering.peering-1 : k => v.id }
}

output "reverse_peering_connections" {
  value = { for k, v in google_compute_network_peering.reverse-peering : k => v.id }
}
