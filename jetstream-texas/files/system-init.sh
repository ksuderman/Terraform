#!/usr/bin/env bash
set -eu
device=$1
mountpoint=$2

if [[ ! -e $mountpoint ]] ; then
    echo "Creating mount point directory $mountpoint"
    mkdir $mountpoint
    # Using the mountpoint directory as the test for formatting
    # is likely not the best, but should be sufficient.
    mkfs.ext4 $device
    echo "Mounting $device"
    mount $device $mountpoint
    echo "Updating /etc/fstab"
    echo "$device    $mountpoint    ext4    defaults    0 0" >> /etc/fstab

    df -h $mountpoint
fi

apt -qq update
# Don't update docker as it blocks the upgrade as even 
# with -y a user prompt is displayed 
apt-mark hold docker.io
apt -qq upgrade -y
