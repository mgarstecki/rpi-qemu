# RPI QEMU

Some personal scripts to work with QEMU to emulate a Raspberry Pi. Helps system automation work by avoiding the hassle of flashing and booting fresh images on a physical Pi for every new test.

Works with customized [ArchLinuxARM](https://archlinuxarm.org/platforms/armv6/raspberry-pi) images that I currently store privately due to their size.

Only for Raspberry Pi 1 at the moment.

## Prerequisites

Install QEMU with ARM support. Distro-dependent. You should be ok if you can run `qemu-system-arm --version`.

Get a QEMU-compatible kernel image. See comments in `qemu-usernet.sh` for the source.

You will also need a qemu disk image with a Linux distro to boot on, see the next section for an ArchLinux example.

## Creating an Archlinux ARM image customized for QEMU

You will need root rights to do this.

Create the image file itself (here 8G in max size) : `qemu-img create -f qcow2 rpi.sd.img 8G`

Activate it as a local device through NBD : `sudo qemu-nbd -c /dev/nbd0 rpi.sd.img`

Follow the procedure on [https://archlinuxarm.org/platforms/armv6/raspberry-pi](https://archlinuxarm.org/platforms/armv6/raspberry-pi), but target `/dev/nbd0` instead of `/dev/sdX`.

Before unmounting, modify `etc/fstab` in the `root` partition so that `/` gets mounted from `/dev/sda2`.

Once you're done and have unmounted the partitions, disable the NBD device with `sudo qemu-nbd -d /dev/nbd0`.

## Contents

* `qemu-usernet.sh` : launch an ARM VM with QEMU with an above-customized image and a pre-downloaded kernel. Expose port 22 on host port 2222.
