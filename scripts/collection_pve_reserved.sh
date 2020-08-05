#!/bin/bash

# Vars
data_dir=/root/scripts/collection/data
vms_dir=/etc/pve/qemu-server
remote_host=root@IPADDRESS:/root/collection/data/srv/
vms_cores=$(cat $vms_dir/*.conf | grep cores | awk {'print $2'})
vms_memory=$(cat $vms_dir/*.conf | grep memory | awk {'print $2'})
node_cores=$(/usr/sbin/dmidecode -t processor | grep 'Thread Count' | awk {'print $3'} | awk '{ SUM += $1 } END {print SUM}')
node_ram=$(bc <<< $(cat /proc/meminfo | grep MemTotal | awk {'print $2'})/1024/1024)


# Сollection information
mkdir -p /root/scripts/collection/data
echo '1' > $data_dir/output
echo $(hostname)  >> $data_dir/output
#First output is reserved cores for VMs
echo $vms_cores | tr -s ' ' '\n' | awk '{ SUM += $1 } END {print SUM}' >> $data_dir/output
#Second output is reserved memroy for VMs (Gb)
bc <<< $(echo $vms_memory | tr -s ' ' '\n' | awk '{ SUM += $1 } END {print SUM}')/1024 >> $data_dir/output
#Third output in file is stock cores on Node
echo $node_cores >> $data_dir/output
#Fourth outpu in file is stock ram on Node (Gb)
echo $node_ram >> $data_dir/output
cat $data_dir/output | tr -s '\n' ' ' > $data_dir/$(hostname)
scp $data_dir/$(hostname) $remote_host
