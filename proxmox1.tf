module "proxmox1" {
  source                = "./modules/f5xc/ce/proxmox"
  f5xc_tenant           = var.f5xc_tenant
  f5xc_api_url          = var.f5xc_api_url
  f5xc_namespace        = var.f5xc_namespace
  f5xc_api_token        = var.f5xc_api_token
  f5xc_api_ca_cert      = var.f5xc_api_ca_cert
  f5xc_reg_url          = var.f5xc_reg_url
  pm_api_url            = var.pm_api_url
  pm_api_token_id       = var.pm_api_token_id
  pm_api_token_secret   = var.pm_api_token_secret
  pve_host              = var.pve_host
  pve_user              = var.pve_user
  #pve_password          = var.pve_password
  pve_private_key       = file("/Users/mwiget/.ssh/id_ed25519")
  pm_pool               = "Datacenter"
  pm_clone              = "ver-ce-template"
  pm_storage            = "local-lvm"

  admin_password        = var.admin_password
  custom_labels         = {
    "site-mesh" = var.project_prefix
  }
  #  outside_vip           = "192.168.40.110"
  nodes   = [
    { name = "master-0", node = "prox1", datastore = "datastore2", ipaddress = "192.168.40.111/24" }
    #    { name = "master-1", node = "192.168.40.100", datastore = "datastore2", ipaddress = "192.168.40.112/24" },
    #{ name = "master-2", node = "192.168.40.100", datastore = "datastore2", ipaddress = "192.168.40.113/24" }
  ]
  outside_network       = "vmbr0"
  dnsservers            = {
    primary = "8.8.8.8"
    secondary = "8.8.4.4"
  }
  publicdefaultgateway  = "192.168.40.1"
  publicdefaultroute    = "0.0.0.0/0"
  guest_type            = "other3xLinux64Guest"
  cpus                  = 4
  memory                = 14336
  certifiedhardware     = "vmware-voltmesh"
  cluster_name          = format("%s-proxmox1", var.project_prefix)
  sitelatitude          = "47"
  sitelongitude         = "8.5"
}

output "proxmox1" {
  value = module.proxmox1
  sensitive = true
}
