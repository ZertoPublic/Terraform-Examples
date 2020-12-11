provider "vsphere" {
  user                 = local.vs_creds.username
  password             = local.vs_creds.password
  vsphere_server       = local.vs_creds.ip_address
  allow_unverified_ssl = true
}


data "vsphere_datacenter" "dc" {
  name = var.datacenter_name
  #name = "str - enter datacenter name here"
}

data "vsphere_datastore" "datastore" {
  name          = "str - enter datastore name"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "str - enter network name"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = "str - enter pool name"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "str - enter template name"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "aws_secretsmanager_secret_version" "creds" {
  secret_id     = "str - enter AWS secret name"
}

locals {
  vs_creds = jsondecode(
    data.aws_secretsmanager_secret_version.creds.secret_string
  )
}

resource "vsphere_virtual_machine" "vm" {
  name             = "enter name os ZVM"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  firmware         = "efi"
  scsi_type        = "lsilogic-sas"

  num_cpus = 2
  memory   = 4096
  guest_id = "windows9Server64Guest"

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label            = "disk0"
    size             = "40"
    thin_provisioned = false
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      windows_options {
        computer_name  = "name of computer"
        admin_password = local.vs_creds.password
      }

      network_interface {
        ipv4_address = "ip of guest"
        ipv4_netmask = 24
      }

      ipv4_gateway    = "gateway of guest"
      dns_server_list = list("dns servers")
    }
  }
  provisioner "remote-exec" {
    inline = [
      "\"C:\\Program Files\\Zerto Virtual Replication VMware Installer.exe\" -s VCenterHostName=ENTERVCIPHERE VCenterUserName=username VCenterPassword=password"
    ]
    connection {
      type     = "winrm"
      user     = "Administrator"
      password = local.vs_creds.password
      host     = "ip address here"
      https    = false
      insecure = false
    }
  }
}
