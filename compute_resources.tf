resource "digitalocean_droplet" "proxy-server" {
  name   = "prox-server"
  region = "${var.region}"
  image  = "${var.image}"
  size   = "${var.size_4_gb}"

  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file(var.pvt_key)}"
      agent = false
      timeout = "5m"
    }

    inline = [
      "export PATH=$PATH:/usr/bin",
      # install haproxy 1.5
      "sudo add-apt-repository -y ppa:vbernat/haproxy-1.5",
      "sudo apt-get update",
      "sudo apt-get -y install haproxy",

      # download haproxy conf
      "sudo wget https://gist.githubusercontent.com/thisismitch/91815a582c27bd8aa44d/raw/8fc59b7cb88a2be9b802cd76288ca1c2ea957dd9/haproxy.cfg -O /etc/haproxy/haproxy.cfg",

      # replace ip address variables in haproxy conf to use droplet ip addresses
      "sudo sed -i 's/HAPROXY_PUBLIC_IP/${digitalocean_droplet.proxy-server.ipv4_address}/g' /etc/haproxy/haproxy.cfg",

      # restart haproxy to load changes
      "sudo service haproxy restart"
    ]


    // You can also run it as docker container - just don't forget to copy the haproxy.cfg file
    //inline = [
    //  "sudo curl -sSL https://get.docker.com/ | sh",
    //  "sudo usermod -aG docker `echo $USER`",
    //  "sudo docker run -d -p 80:80 haproxy"
   // ]


  }
}
