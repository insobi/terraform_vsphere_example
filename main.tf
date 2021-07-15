terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.0.2"
    }
  }
  required_version = "1.0.0"
}

provider "vsphere" {
  user                 = var.vsphere_credential.user
  password             = var.vsphere_credential.password
  vsphere_server       = var.vsphere_credential.vsphere_server
  allow_unverified_ssl = var.vsphere_credential.allow_unverified_ssl
}

data "vsphere_datacenter" "dc" {
  name = var.dc
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network1" {
  name          = var.network1
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_folder" "folder" {
  path = var.folder
}

data "vsphere_virtual_machine" "template" {
  name          = var.template
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vms" {
  for_each         = var.virtual_machine
  name             = each.value.name
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = each.value.num_cpus
  memory           = each.value.memory
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  folder           = data.vsphere_folder.folder.path

  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0

  network_interface {
    network_id = data.vsphere_network.network1.id
  }

  disk {
    label            = "disk0"
    size             = each.value.disk.size
    eagerly_scrub    = each.value.disk.eagerly_scrub
    thin_provisioned = each.value.disk.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = each.value.customize.host_name
        domain    = each.value.customize.domain
      }

      network_interface {
        ipv4_address = each.value.customize.address
        ipv4_netmask = each.value.customize.netmask
      }
    }
  }

  provisioner "local-exec" {
    command = "echo '${self.default_ip_address}'"
  }
}