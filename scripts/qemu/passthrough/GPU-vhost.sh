sudo /home/rs/RosenBridge/qemu/build/qemu-system-x86_64 \
        -smp 32 \
        -m 65536 \
        -enable-kvm \
        -hda /mnt/virtual_disks/vms/vhost.qcow2 \
        -net user,hostfwd=::28882-:22 \
        -net nic \
        -device vfio-pci,host=0000:cd:00.0,id=GPU0 \
        -drive if=none,id=drive1,format=raw,file=/dev/nvme2n1,cache=none \
        -device vhost-blk-pci,id=blk1,drive=drive1,num-queues=16 \
        #-nographic
        # -append "root=/dev/sda2 console=ttyS0" \
        # -kernel /boot/vmlinuz-5.15.0-124-generic \
        # -initrd /boot/initrd.img-5.15.0-124-generic \
