#VMWare ESXi revert multiple VM's back to single snapshot.

[What is this script doing?](#what)  
[How do I use it?](#how)  
[NEW: Create snapshots for multiple VM's](#resnap)

Used in lab environment where a single VMWare ESXi host is running multiple VM's that have a single snapshot.  We want to revert all the vms with a certain name back to that single snapshot.  If I were using a system that was supported by vSphere Perl SDK this would be a LOT easier.  Alas they don't see OSX as a valid dev/admin platform as of yet.  And I'm not going to waste resources on a vMA for such a simple task.

**NOT TESTED** If multiple snapshots exist, not sure what will happen.

**Environment tested:**
  
SERVER = VMWare ESXi 5.5 U1

CLIENT = OSX 10.9.4

All snapshots were created in the powered off state.

SSH must be enabled on the ESXi host: [VMware KB](http://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=2004746)


###<a name="what"></a>What is this script doing?

1. Find all VMs with the name "mapr" and dump the `VM_ID` to a file called `nodeid.txt`  
`vim-cmd vmsvc/getallvms|grep mapr`

2. Get the `SNAP_ID` for each `VM_ID`  
`vim-cmd vmsvc/get.snapshotinfo $VM_ID` 

3. Finally put it all together reverting to snapshot  
`vim-cmd vmsvc/snapshot.revert $VM_ID $SNAP_ID 0` 

4. And since I want to get back to breaking the VM's as quickly as possible, power them on.  
`vim-cmd vmsvc/power.on $VM_ID`

###<a name="how"></a>How do I use it?###

Change the variable in `revert.sh` to `TARGET_VMS="your_vmnames"`

Execute directly on ESXi host or directly from your client machine via:

 `ssh root@esxihostname < revert.sh`



**Output**

    $ ssh root@10.3.3.50 < revert.sh
    Pseudo-terminal will not be allocated because stdin is not a terminal.
    vim-cmd vmsvc/snapshot.revert 27 3 0
    Revert Snapshot:
    |-ROOT
    --Snapshot Name        : prepared for install
    --Snapshot Id        : 3
    --Snapshot Desciption  : clush configured
    tmp and all traces of mapr removed
    --Snapshot Created On  : 8/21/2014 22:0:23
    --Snapshot State       : powered off
    Powering on VM:
    vim-cmd vmsvc/snapshot.revert 28 4 0
    Revert Snapshot:
    |-ROOT
    --Snapshot Name        : prepared for install
    --Snapshot Id        : 4
    --Snapshot Desciption  :
    --Snapshot Created On  : 8/21/2014 22:0:46
    --Snapshot State       : powered off
    Powering on VM:
    vim-cmd vmsvc/snapshot.revert 29 4 0
    Revert Snapshot:
    |-ROOT
    --Snapshot Name        : prepared for install
    --Snapshot Id        : 4
    --Snapshot Desciption  :
    --Snapshot Created On  : 8/21/2014 22:0:52
    --Snapshot State       : powered off
    Powering on VM:
    vim-cmd vmsvc/snapshot.revert 30 3 0
    Revert Snapshot:
    |-ROOT
    --Snapshot Name        : prepared for install
    --Snapshot Id        : 3
    --Snapshot Desciption  :
    --Snapshot Created On  : 8/21/2014 22:1:4
    --Snapshot State       : powered off
    Powering on VM:
    vim-cmd vmsvc/snapshot.revert 31 3 0
    Revert Snapshot:
    |-ROOT
    --Snapshot Name        : prepared for install
    --Snapshot Id        : 3
    --Snapshot Desciption  :
    --Snapshot Created On  : 8/21/2014 22:1:12
    --Snapshot State       : powered off
    Powering on VM:

###<a name="resnap"></a>(re)Create snapshots for multiple VM's###


###How do I use it?###

Change the variable in `resnap.sh` to `TARGET_VMS="your_vmnames"`

Execute directly on ESXi host or directly from your client machine via:

 `ssh root@esxihostname < resnap.sh`
