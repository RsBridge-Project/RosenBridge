#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with root privileges."
  exit 1
fi

VFIO_CONF="/etc/modprobe.d/vfio.conf"
OPTIONS_LINE="options vfio-pci ids=10de:26b9 disable_vga=1"

# Check if a parameter is passed
if [ $# -ne 1 ]; then
  echo "Usage: $0 {add|del}"
  exit 1
fi

# Check if the file exists, create it if it doesn't
if [ ! -f "$VFIO_CONF" ]; then
  touch "$VFIO_CONF"
  echo "File $VFIO_CONF does not exist. It has been created."
fi

# Add parameters
if [ "$1" == "add" ]; then
  # Check if the line already exists
  if ! grep -q "$OPTIONS_LINE" "$VFIO_CONF"; then
    echo "$OPTIONS_LINE" >> "$VFIO_CONF"
    echo "Added $OPTIONS_LINE to $VFIO_CONF"
  else
    echo "$OPTIONS_LINE already exists in $VFIO_CONF, no changes made."
  fi
# Remove parameters
elif [ "$1" == "del" ]; then
  # Use sed to delete the matching line
  sed -i "/$OPTIONS_LINE/d" "$VFIO_CONF"
  echo "Removed $OPTIONS_LINE from $VFIO_CONF"
else
  echo "Invalid argument: $1. Please use {add|del}."
  exit 1
fi

echo "done!"
