# Create a new domain record
resource "digitalocean_domain" "dns-record" {
  name = "my-dns-record"
  ip_address = "${digitalocean_droplet.proxy-server.ipv4_address}"
}

resource "digitalocean_record" "www" {
  domain = "${digitalocean_domain.dns-record.name}"
  type = "CNAME"
  name = "www"
  value = "@"
}