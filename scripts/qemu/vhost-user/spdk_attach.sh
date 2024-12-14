#!/bin/bash  
SPDK="/home/rs/spdk"
nvme_pci_addr="0000:c2:00.0"
RPC="$SPDK/scripts/rpc.py"  

$RPC bdev_nvme_detach_controller nvme1
echo "$RPC bdev_nvme_attach_controller -b nvme1 -t pcie -a $nvme_pci_addr"
$RPC bdev_nvme_attach_controller -b nvme1 -t pcie -a $nvme_pci_addr
echo "$RPC bdev_split_create nvme1n1 1"
$RPC bdev_split_create nvme1n1 1

# echo "$RPC bdev_nvme_attach_controller -b nvme1 -t pcie -a $nvme_pci_addr2"
# $RPC bdev_nvme_attach_controller -b nvme1 -t pcie -a $nvme_pci_addr2
# echo "$RPC bdev_split_create nvme1n1 6"
# $RPC bdev_split_create nvme1n1 5

for ((i=0; i<1; i++)); do  
    rm /var/tmp/vhost.0$i
done  
# for ((i=0; i<6; i++)); do  
#     rm /var/tmp/vhost.1$i
# done  
for ((i=0; i<1; i++)); do  
    $RPC vhost_delete_controller vhost.0$i
done
for ((i=0; i<1; i++)); do  
    $RPC vhost_create_blk_controller --cpumask 0x1 vhost.0$i nvme1n1p$i
done
