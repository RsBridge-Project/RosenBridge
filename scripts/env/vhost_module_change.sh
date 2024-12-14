#!/bin/bash  
  
if [ "$#" -ne 1 ]; then  
    echo "Usage: $0 <origin|custom|reload>"  
    exit 1  
fi 
SCRIPT_PATH=$(realpath "$0")
UPPER_DIR=$(dirname $(dirname "$SCRIPT_DIR"))
path="/home/rs/gds/RosenBridge/kernel_modules/vhost"
KDIR="/lib/modules/$(uname -r)/kernel/drivers/vhost"

unload_modules() { 
    rmmod vhost_blk 
    rmmod vhost
    rmmod vhost_iotlb 
}  

unload_modified_modules() {
    rmmod vhost_blk  
    rmmod vhost
    rmmod vhost_iotlb 
} 

unload_modified_vhost_only() {
    rmmod vhost_blk  
}  

load_custom_modules_deps() {
    local path=$1    
    insmod $path/vhost_iotlb.ko  
    insmod $path/vhost.ko 
}  

load_modified_modules() {  
    local path=$1  
    insmod $path/vhost_iotlb.ko  
    insmod $path/vhost.ko
    insmod $path/vhost_blk.ko   
}  

load_modified_vhost_only() {  
    local path=$1  
    insmod $path/vhost_blk.ko  
}  
# 根据参数决定操作  
case "$1" in  
    "origin")  
        unload_modules  
        load_modified_modules $KDIR 
        ;;  
    "custom")  
        unload_modules  
        load_modified_modules $path
        ;;
    *)  
        echo "Invalid parameter. Usage: $0 <origin|custom>"  
        exit 1  
        ;;  
esac