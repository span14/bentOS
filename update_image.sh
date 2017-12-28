#!/bin/bash

if [ -d /mnt/tmpbentOS ]; then
    rm -rf /mnt/tmpbentOS
fi

if [ -d /tmp/bentOS ]; then
    rm -rf /tmp/bentOS
fi

mkdir /mnt/tmpbentOS
mkdir /tmp/bentOS
cp ./kernel /tmp/bentOS
# no filesystem yet
cp ./floppy.img /tmp/bentOS

/sbin/losetup /dev/loop0 /tmp/bentOS/floppy.img
mount /dev/loop0 /mnt/tmpbentOS

cp -f /tmp/bentOS/kernel /mnt/tmpbentOS
# no filesystem yet

umount /dev/loop0 
/sbin/losetup -d floppy.img
cp -f /tmp/bentOS/kernel ./
rm -rf /tmp/bentOS
rm -rf /mnt/tmpbentOS



