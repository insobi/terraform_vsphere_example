variable "vsphere_credential" {
  type = object({
    user                 = string
    password             = string
    vsphere_server       = string
    allow_unverified_ssl = bool
  })
}

variable "dc" {
  type = string
}

variable "datastore" {
  type = string
}

variable "pool" {
  type = string
}

variable "network1" {
  type = string
}

variable "folder" {
  type = string
}

variable "template" {
  type = string
}

variable "virtual_machine" {
  type    = map(any)
  default = {}
}

variable "network_interface" {
  type    = map(any)
  default = {}
}