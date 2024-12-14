sudo /home/rs/RosenBridge/qemu/build/qemu-system-x86_64 \
        -smp 32 \
        -m 65536 \
        -enable-kvm \
        -hda /mnt/virtual_disks/vms/root0.qcow2 \
        -net user,hostfwd=::28881-:22 \
        -net nic \
        -drive if=none,id=drive1,format=raw,file=/mnt/disks/disk0.raw,cache=none \
        -device virtio-blk-pci,id=blk1,drive=drive1,num-queues=16 \
        -device vfio-pci,host=0000:cd:00.0,id=GPU0 \
        -overcommit mem-lock=on \
        # -append "root=/dev/sda2 console=ttyS0" \
        # -nographic
        # -kernel /boot/vmlinuz-5.15.0-124-generic \
        # -initrd /boot/initrd.img-5.15.0-124-generic \
