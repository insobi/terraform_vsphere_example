output "virtual_machines" {
  value = [for vm in vsphere_virtual_machine.vms : vm.name]
}