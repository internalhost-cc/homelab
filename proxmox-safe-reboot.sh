#!/bin/bash
# Stop all running VMs
for vmid in $(qm list | awk 'NR>1 && $3=="running" {print $1}'); do
    qm shutdown $vmid --timeout 60
done

# Stop all running LXCs
for lxcid in $(pct list | awk 'NR>1 && $2=="running" {print $1}'); do
    pct shutdown $lxcid --timeout 60
done

# Wait to ensure proper shutdown
sleep 60

# Reboot the Proxmox host
reboot
