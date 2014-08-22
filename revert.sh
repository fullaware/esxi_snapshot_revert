#!/bin/bash
rm nodeid.txt
vim-cmd vmsvc/getallvms|grep mapr|awk '{printf $1"\n"}' >>nodeid.txt

for vmid in $(cat nodeid.txt);
    do
    snapid=$(vim-cmd vmsvc/get.snapshotinfo $vmid|grep id|awk '{print $3}'|sed 's/,//');
    echo "vim-cmd vmsvc/snapshot.revert $vmid $snapid 0";
    vim-cmd vmsvc/snapshot.revert $vmid $snapid 0;
    vim-cmd vmsvc/power.on $vmid;
    done
