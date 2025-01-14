#!/bin/bash  
# 定义环境变量和sh文件路径
SPDK="/home/rs/spdk"
devices=("nvme1")
SET_UP="$SPDK/scripts/setup.sh"
nvme_pci_addr="0000:c2:00.0"
Hugemem_size=16384
RPC="$SPDK/scripts/rpc.py"  
VHOST="$SPDK/build/bin/vhost"
operation=reset
operation1=config
operation2=status



bash $SET_UP $operation &

for device in "${devices[@]}"; do 
    echo "reseting the nvme device"
    sudo nvme detach-ns "/dev/$device" -c 0 -n 1
    sudo nvme delete-ns "/dev/$device" -n 1
    sudo nvme create-ns "/dev/$device" -s 650000000 -c 650000000 -f 0 -d 0 -m 0
    sudo nvme attach-ns "/dev/$device" -c 0 -n 1
    sudo nvme reset  "/dev/$device"
    echo "reset done"
done
# 使用nohup在后台运行第一个脚本，并将输出重定向到nohup.out文件中  


echo "HUGEMEM=$Hugemem_size PCI_ALLOWED=$nvme_pci_addr $SET_UP $operation1"
HUGEMEM=$Hugemem_size PCI_ALLOWED=$nvme_pci_addr $SET_UP $operation1
echo "HUGEMEM=$Hugemem_size PCI_ALLOWED=$nvme_pci_addr $SET_UP $operation2"
HUGEMEM=$Hugemem_size PCI_ALLOWED=$nvme_pci_addr $SET_UP $operation2

$VHOST -S /var/tmp -m 0x1 
