/home/rs/RosenBridge/qemu/build/qemu-system-x86_64 \
	-smp 32 \
	-m 4096 \
	-enable-kvm \
	-hda /mnt/virtual_disks/vms/vhost.qcow2 \
	-net user,hostfwd=::28882-:22 \
	-net nic \
	-chardev socket,id=char0,path=/var/tmp/vhost.00 \
	-device vhost-user-blk-pci,id=blk0,chardev=char0,num-queues=8 \
	-overcommit mem-lock=on \
	-object memory-backend-file,id=mem,size=4G,mem-path=/dev/hugepages/0,share=on \
	-numa node,memdev=mem