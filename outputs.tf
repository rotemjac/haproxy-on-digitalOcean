# The droplet public IP
output "droplet_ip" {
  value = "${digitalocean_droplet.proxy-server.ipv4_address}"
}

# The FQDN for the record
output "fqdn" {
  value = "${digitalocean_record.www.fqdn}"
}