# f5xc-proxmox-ce

Deploy F5 Distributed Cloud CE on proxmox single node or 3-node cluster.

## install proxmox on hetzner rootserver

- install debian-11 via rescue, installimage, disabling swraid. 
- follow sw install instructions from https://pve.proxmox.com/wiki/Cloud-Init_Support
- install tailscale, mosh, tmux, vim-nox, bwm-ng
- install dnsmasq and dnsutils

```
$ cat /etc/dnsmasq.conf
interface=vmbr0
dhcp-range=10.0.0.100,10.0.0.200,12h
dhcp-option=vmbr0,3,10.0.0.1
server=8.8.8.8
server=1.1.1.1
dhcp-leasefile=/var/lib/misc/dnsmasq.leases
```

- network setup with Masquerading (NAT) with iptables according to https://pve.proxmox.com/wiki/Network_Configuration
- set root password, used also for web interface at https:server:8006


```
mkdir -p /var/lib/vz/template/qcow/
cd /var/lib/vz/template/qcow/

# download ver-ce qcow2 image from f5.com/cloud
wget https://downloads.volterra.io/releases/images/2021-03-01/centos-7.2009.5-202103011045.qcow2

# resize disk to 50G
qemu-img resize /var/lib/vz/template/qcow/centos-7.2009.5-202103011045.qcow2 50G

# create a new VM with VirtIO SCSI controller
qm create 9000 --memory 2048 --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-pci

# import the downloaded disk to the local-lvm storage, attaching it as a SCSI drive
qm set 9000 --scsi0 local-lvm:0,import-from=/var/lib/vz/template/qcow/centos-7.2009.5-202103011045.qcow2 

# set name
qm set 9000 --name ver-ce-template

# configure a CD-ROM drive, which will be used to pass the Cloud-Init data to the VM.
# qm set 9000 --ide2 local-lvm:cloudinit
qm set 9000 --boot order=scsi0
qm set 9000 --serial0 socket --vga serial0
qm template 9000
```

```
# list vm's
root@prox1 ~ # qm list
    VMID NAME                 STATUS     MEM(MB)    BOOTDISK(GB) PID       
    9000 ver-ce-template      stopped    2048               0.00 0        
```

https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/guides/cloud_init

