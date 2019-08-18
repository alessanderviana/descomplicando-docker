variable "region" {
  default = "us-central1"
}
variable "gcp_project" {
  default = "infra-como-codigo-e-automacao"
}
variable "credentials" {
  default = "~/repositorios/terraform/gcloud/credentials.json"
}
variable "vpc_name" {
  default = "default"
}
variable "user" {
  default = "ubuntu"
}
variable "pub_key" {
  default = "~/repositorios/terraform/alessander-tf.pub"
}
variable "priv_key" {
  default = "~/repositorios/terraform/alessander-tf"
}

// Configure the Google Cloud provider
provider "google" {
 credentials = "${file("${var.credentials}")}"
 project     = "${var.gcp_project}"
 region      = "${var.region}"
}

// Linux instance - Ubuntu 16.04
resource "google_compute_instance" "descomplicando-docker" {
 count = 1
 name         = "descomplicando-docker-${count.index + 1}"
 # machine_type = "n1-standard-1"  # 3.75 GB RAM
 machine_type = "g1-small"  # 1.7 GB RAM
 zone         = "${var.region}-b"

 tags = [ "descomplicando-docker-${count.index + 1}" ]

 boot_disk {
   initialize_params {
     # image = "ubuntu-1604-xenial-v20190306"
     image = "ubuntu-1804-bionic-v20190514"
     # image = "ubuntu-1904-disco-v20190514"
   }
 }

 network_interface {
   subnetwork = "default"
   access_config { }
 }

 metadata {
   ssh-keys = "${var.user}:${file("${var.pub_key}")}"
 }

 metadata_startup_script = <<SCRIPT
    curl -fsSL https://get.docker.com/ | bash
    usermod -aG docker ubuntu
SCRIPT

}
