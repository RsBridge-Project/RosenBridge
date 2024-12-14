sudo /home/qs/RosenBridge/qemu/build/qemu-system-x86_64 \
        -smp 4 \
        -m 4096 \
        -enable-kvm \
        -hda /home/qs/virtual_disks/vms/root0.qcow2 \
        -net user,hostfwd=::28881-:22 \
        -net nic \
        -drive if=none,id=drive1,format=raw,file=/home/qs/virtual_disks/disks/disk0.raw,cache=none \
        -device virtio-blk-pci,id=blk1,drive=drive1,num-queues=4 \
        -overcommit mem-lock=on \
        # -nographic
       
