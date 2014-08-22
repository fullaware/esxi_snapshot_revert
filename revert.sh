#!/bin/bash
TARGET_VMS="mapr"

rm nodeid.txt
vim-cmd vmsvc/getallvms|grep $TARGET_VMS|awk '{printf $1"\n"}' >>nodeid.txt

for VM_ID in $(cat nodeid.txt);
    do
    snapid=$(vim-cmd vmsvc/get.snapshotinfo $VM_ID|grep id|awk '{print $3}'|sed 's/,//');
    echo "vim-cmd vmsvc/snapshot.revert $VM_ID $SNAP_ID 0";
    vim-cmd vmsvc/snapshot.revert $VM_ID $SNAP_ID 0;
    vim-cmd vmsvc/power.on $VM_ID;
    done
