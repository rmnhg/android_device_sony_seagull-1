#!/sbin/sh

set -e

# Detect the exact model from the LTALabel partition
# This looks something like:
# 1291-1739_5-elabel-d5103-row.html
mkdir -p /lta-label
mount -r -t ext4 /dev/block/platform/msm_sdcc.1/by-name/LTALabel /lta-label
variant=`ls /lta-label/*.html | sed s/.*-elabel-// | sed s/-row.html// | tr -d '\n\r'`
umount /lta-label

mount -t ext4 /dev/block/platform/msm_sdcc.1/by-name/system /system
mount -t vfat /dev/block/platform/msm_sdcc.1/by-name/modem /firmware
# Symlink the correct modem blobs
basedir="/firmware"
cd $basedir
find . -type f | while read file; do ln -sf $basedir$file /system/etc/firmware/$file ; done

exit 0

