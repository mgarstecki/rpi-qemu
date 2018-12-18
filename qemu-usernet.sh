#!/usr/bin/env bash

# Copyright (C) 2018 Mathieu Garstecki
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.

set -o errexit -o nounset

diskfile=$1

# From : https://github.com/dhruvvyas90/qemu-rpi-kernel
kernel=./kernel-qemu-4.4.34-jessie
#kernel=./kernel-qemu-4.14.50-stretch

qemu-system-arm \
  -kernel kernel-qemu-4.4.34-jessie \
  -cpu arm1176 \
  -m 256 \
  -M versatilepb \
  -serial mon:stdio \
  -append "root=/dev/sda2 rootfstype=ext4 rw" \
  -hda "$diskfile" \
  -nographic \
  -net nic,macaddr=de:ad:be:af:ca:fe -net user,hostfwd=tcp::2222-:22
