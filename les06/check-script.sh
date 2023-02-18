#!/bin/bash
cd /mnt
echo "CHECK NFS after reboot" | tee -a client-history.log
mount | grep mnt | tee -a client-history.log
touch upload/file-from-client.txt
ls -la | tee -a client-history.log
ls -la upload | tee -a client-history.log