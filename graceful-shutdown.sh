/usr/local/bin/graceful-shutdown.sh

#!/bin/bash

# Graceful shutdown of all running VMs
for vmid in $(qm list | awk '$2 ~ /^[0-9]+$/ && $NF ~ /running/ {print $1}'); do
    echo "Shutting down VM $vmid..."
    qm shutdown $vmid --timeout 60
done

# Graceful shutdown of all running LXCs
for lxcid in $(pct list | awk '$1 ~ /^[0-9]+$/ && $NF ~ /running/ {print $1}'); do
    echo "Shutting down LXC $lxcid..."
    pct shutdown $lxcid --timeout 60
done

# Wait for shutdown processes to complete
sleep 60
