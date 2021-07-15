dc        = "DC1"
datastore = "DC1-Datastore"
pool      = "DC1-Pool"
network1  = "DC1-Network"
folder    = "MyFolder"
template  = "Templete_VM"

virtual_machine = {

  vm1 = {
    name     = "WEB"
    num_cpus = 2
    memory   = 8192
    disk = {
      size             = 30       # should be greater than template vm
      eagerly_scrub    = false    # should be same as template vm
      thin_provisioned = false    # should be same as template vm
    }
    customize = {
      host_name = "web"
      domain    = "test.internal"
      address   = "192.168.100.101"
      netmask   = "24"
    }
  }

  vm2 = {
    name     = "APP"
    num_cpus = 2
    memory   = 8192
    disk = {
      size             = 30
      eagerly_scrub    = false
      thin_provisioned = false
    }
    customize = {
      host_name = "app"
      domain    = "test.internal"
      address   = "192.168.100.102"
      netmask   = "24"
    }
  }

  vm3 = {
    name     = "DB"
    num_cpus = 2
    memory   = 8192
    disk = {
      size             = 30
      eagerly_scrub    = false
      thin_provisioned = false
    }
    customize = {
      host_name = "db"
      domain    = "test.internal"
      address   = "192.168.100.103"
      netmask   = "24"
    }
  }
}