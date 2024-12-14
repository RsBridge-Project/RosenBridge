#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with root privileges"
  exit 1
fi

BLACKLIST_FILE="/etc/modprobe.d/blacklist.conf"

MODULES=("nvidia" "nvidia_uvm" "nvidia_drm" "nvidia_modeset" "nouveau")

if [ "$1" != "add" ] && [ "$1" != "del" ]; then
  echo "Usage: $0 {add|del}"
  exit 1
fi

function add_to_blacklist() {
  for module in "${MODULES[@]}"; do
    if ! grep -q "^blacklist $module" "$BLACKLIST_FILE"; then
      echo "blacklist $module" >> "$BLACKLIST_FILE"
      echo "Added $module to the blacklist"
    else
      echo "$module is already in the blacklist"
    fi
  done
}

function remove_from_blacklist() {
  for module in "${MODULES[@]}"; do
    sed -i "/^blacklist $module/d" "$BLACKLIST_FILE"
    if ! grep -q "^blacklist $module" "$BLACKLIST_FILE"; then
      echo "Removed $module from the blacklist"
    else
      echo "$module was not found in the blacklist"
    fi
  done
}

case "$1" in
  add)
    add_to_blacklist
    ;;
  del)
    remove_from_blacklist
    ;;
esac

echo "done!"
