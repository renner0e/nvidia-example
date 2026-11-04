#!/usr/bin/bash

set -ouex pipefail

# this adds bootc and ostree to the initramfs
# or else everything brokey
# can be removed at some point, this is upstream now
cp /usr/share/doc/bootc/baseimage/dracut/usr/lib/dracut.conf.d/10-bootc-base.conf /usr/lib/dracut/dracut.conf.d/

KERNEL_VERSION=$(rpm -q --queryformat="%{evr}.%{arch}" kernel-core)
INITRAMFS="/usr/lib/modules/${KERNEL_VERSION}/initramfs.img"

DRACUT_NO_XATTR=1 /usr/bin/dracut \
  --kver "${KERNEL_VERSION}" \
  --reproducible \
  --verbose \
  --force \
  "${INITRAMFS}"

chmod 0600 "${INITRAMFS}"
