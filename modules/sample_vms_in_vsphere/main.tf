provider "vsphere" {
  user                 = local.vs_creds.username
  password             = local.vs_creds.password
  vsphere_server       = local.vs_creds.ip_address
  allow_unverified_ssl = true
}


data "vsphere_datacenter" "dc" {
  name = "str - enter name of dataCenter here"
}

data "vsphere_datastore" "datastore" {
  name          = "str - enter name of datastore here"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "str - enter name of VM network here"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = "str - enter RP here"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "str - enter template name here"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "aws_secretsmanager_secret_version" "creds" {
  secret_id     = "Enter AWS secrets manager creds here"
}

data "vsphere_tag_category" "category" {
  name          = "str - enter tag category here"
}

data "vsphere_tag" "tag" {
  name          = "str - enter tag Name here"
  category_id   = data.vsphere_tag_category.category.id
}

locals {
  vs_creds = jsondecode(
    data.aws_secretsmanager_secret_version.creds.secret_string
  )
}

resource "vsphere_virtual_machine" "vm" {
  name             = "str - enter name of VM here"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  firmware         = "bios"
  scsi_type        = "pvscsi"

  num_cpus = 2
  memory   = 4096
  guest_id = "centos8_64Guest"
  tags     = [data.vsphere_tag.tag.id]

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label            = "disk0"
    size             = "20"
    thin_provisioned = false
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name  = "linux-test"
        domain     = "localdomain"
      }

      network_interface {
        ipv4_address = "ip address of VM"
        ipv4_netmask = 24
      }

      ipv4_gateway    = "gateway of vm"
      dns_server_list = list("dns server ips")
    }
  }
}
