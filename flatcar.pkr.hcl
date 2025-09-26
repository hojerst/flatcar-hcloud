locals {
  version       = var.version != "" ? var.version : local.flatcar_version_info.FLATCAR_VERSION_ID
  snapshot_name = "${var.snapshot_prefix}${local.version}-${var.arch}"
}

source "hcloud" "builder" {
  image         = "debian-13"
  location      = "${var.location}"
  rescue        = "linux64"
  server_type   = "${local.server_type}"
  snapshot_name = "${local.snapshot_name}"
  ssh_username  = "root"

  snapshot_labels = {
    image_type = "${var.image_type}"
    os         = "flatcar"
  }
}

build {
  sources = ["source.hcloud.builder"]

  provisioner "shell" {
    script = "install-flatcar.sh"
    env = {
      FLATCAR_VERSION = local.version
      FLATCAR_CHANNEL = var.channel
    }
  }
}
