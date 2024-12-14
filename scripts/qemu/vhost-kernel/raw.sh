sudo /home/rs/RosenBridge/qemu/build/qemu-system-x86_64 \
        -smp 32 \
        -m 65536 \
        -enable-kvm \
        -hda /mnt/virtual_disks/vms/vhost.qcow2 \
        -net user,hostfwd=::28882-:22 \
        -net nic \
        -drive if=none,id=drive1,format=raw,file=/dev/nvme2n1,cache=none \
        -device vhost-blk-pci,id=blk1,drive=drive1,num-queues=8
