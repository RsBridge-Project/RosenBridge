#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with root privileges."
  exit 1
fi

GRUB_FILE="/etc/default/grub"
GRUB_CMDLINE_VAR="GRUB_CMDLINE_LINUX"
PARAMS="intel_iommu=on iommu=pt intremap=no_x2apic_optout vfio-pci.ids=10de:26b9"

# Check if a parameter is passed
if [ $# -ne 1 ]; then
  echo "Usage: $0 {add|del}"
  exit 1
fi

# Add parameters
if [ "$1" == "add" ]; then
  # Use sed to directly replace GRUB_CMDLINE_LINUX content with the parameters
  sed -i "s/^${GRUB_CMDLINE_VAR}=.*/${GRUB_CMDLINE_VAR}=\"${PARAMS}\"/" "$GRUB_FILE"
  echo "Parameters added to ${GRUB_CMDLINE_VAR}"
# Remove parameters (essentially clearing GRUB_CMDLINE_LINUX)
elif [ "$1" == "del" ]; then
  # Use sed to directly replace GRUB_CMDLINE_LINUX content with an empty string
  sed -i "s/^${GRUB_CMDLINE_VAR}=.*/${GRUB_CMDLINE_VAR}=\"\"/" "$GRUB_FILE"
  echo "All parameters removed from ${GRUB_CMDLINE_VAR} (cleared)"
else
  echo "Invalid argument: $1. Please use {add|del}."
  exit 1
fi

# Update GRUB configuration
update-grub
echo "GRUB configuration updated."
