source "vmware-iso" "vault" {
  vm_name       = "vault"
  guest_os_type = "ubuntu64Guest"
  version       = "17"
  headless      = false

  memory        = 2048
  cpus          = 1
  cores         = 2
  disk_size     = 16384
  sound         = true
  disk_type_id  = 0
  
  iso_urls =["https://releases.ubuntu.com/22.04.1/ubuntu-22.04.1-live-server-amd64.iso"]
  iso_checksum = "sha256:10f19c5b2b8d6db711582e0e27f5116296c34fe4b313ba45f9b201a5007056cb"
  snapshot_name     = "clean"  
  http_directory    = "http"
  ssh_username      = "admin"
  ssh_password      = "${var.admin_password}"
  shutdown_command  = "sudo shutdown -P now"

  http_content = {
    "/meta-data" = templatefile("${path.root}/http-templates/meta-data", {})
    "/user-data"   = templatefile("${path.root}/http-templates/user-data", { admin_password = "${var.admin_password}" })
  }

  boot_wait = "5s"
  boot_command = [
    "c<wait>",
    "linux /casper/vmlinuz --- autoinstall ds=\"nocloud-net;seedfrom=http://{{.HTTPIP}}:{{.HTTPPort}}/\"",
    "<enter><wait>",
    "initrd /casper/initrd",
    "<enter><wait>",
    "boot",
    "<enter>"
  ]
}

build {
  sources = ["sources.vmware-iso.vault"]
  provisioner "shell" {
    inline = [
            "sleep 30",
            "sudo apt-get update",
            "sudo apt-get install unzip -y",
            "curl -L https://releases.hashicorp.com/vault/1.12.2/vault_1.12.2_linux_amd64.zip -o vault.zip",
            "unzip vault.zip",
            "sudo chown root:root vault",
            "mv vault /usr/local/bin/",
            "rm -f vault.zip"
        ]
  }
}
