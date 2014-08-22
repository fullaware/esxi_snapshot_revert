#!/bin/bash
#  Make sure all VM's are powered off for this phase unless you 
#  want to snapshot the running VM which takes WAY more space

TARGET_VMS="mapr"

rm nodeid.txt
vim-cmd vmsvc/getallvms|grep $TARGET_VMS|awk '{printf $1"\n"}' >>nodeid.txt

for VM_ID in $(cat nodeid.txt);
    do
    echo "vim-cmd vmsvc/snapshot.removeall $VM_ID";
    vim-cmd vmsvc/snapshot.removeall $VM_ID;
    echo "vim-cmd vmsvc/snapshot.create $VM_ID latest_snapshot snapshot_test 0 0";
    vim-cmd vmsvc/snapshot.create $VM_ID latest_snapshot snapshot_test 0 0
    echo "vim-cmd vmsvc/power.on $VM_ID";    
    vim-cmd vmsvc/power.on $VM_ID;
    done
