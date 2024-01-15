#!/bin/sh
#

echo " [+] Create tmpfs mount."
mount -o size=2G -t tmpfs none /blobfuseTemp
if [ $? -ne 0 ]; then
    echo " [-] Failed to mount tmpfs."
    exit 6

echo " [+] Mounting the blob storage account."
/usr/bin/blobfuse2 mount /blobfuseMount --config-file=/Config/config.yaml --tmp-path=/blobfuseTemp
if [ $? -ne 0 ]; then
    echo " [-] Failed to mount the blob storage account."
    exit 1
fi

echo " [+] Mounting EncFS directory at the blob."
/usr/bin/encfs --extpass="cat /Config/encfsPwd.txt " --config=/Config/encfs6.xml /blobfuseMount /crypt
if [ $? -ne 0 ]; then
    echo " [-] Failed to mount the encrypted directory."
    exit 2
fi

echo " [+] Copying files."
cp -vuR /Origin/. /crypt/.
# TODO figure out rsync
#rsync -anvP /Origin/. /crypt/.
#
if [ $? -ne 0 ]; then
    echo " [-] Copy failed."
    exit 3
fi

echo " [+] Unmounting the encrypted drive."
/usr/bin/encfs -u /crypt
if [ $? -ne 0 ]; then
    echo " [-] Unmounting encfs failed."
    exit 4
fi

echo " [+] Unmounting the blob storage account."
/usr/bin/blobfuse2 unmount /blobfuseMount
if [ $? -ne 0 ]; then
    echo " [-] Unmounting the blob storage account failed."
    exit 5
fi

umount /blobfuseMount
