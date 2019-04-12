variable "do_token" {}
variable "ssh_fingerprint" {}
variable "pvt_key" {}

variable "region" {
  default = "BLR1" //Bangalore, India.
}

variable "image" {
  default="ubuntu-18-04-x64"
}

variable "size_4_gb" {
  default="s-2vcpu-4gb"
}

variable "size_16_gb" {
  default="s-6vcpu-16gb"
}

