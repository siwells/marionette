#!/bin/bash

export VM_NAME=${VM_NAME:-"$1"}
export VM_NAME=${VM_NAME:-"omerovm"}

set -e -u
#set -x # DEBUG TRACE

VBOX="VBoxManage --nologo"
NUM_VMS=`$VBOX list vms | grep '"'$VM_NAME'"' | wc -l`

if [[ NUM_VMS -lt 1 ]]
then
    echo "No VM registered with VirtualBox called $VM_NAME"
    exit 1
elif [[ NUM_VMS -gt 1 ]]
then
    echo "More than one VM called $VM_NAME registered with VirtualBox"
    exit 1
else
    RUNNING=`$VBOX list runningvms | grep '"'$VM_NAME'"' | wc -l`
    if [[ $RUNNING -eq 1 ]]
    then
        echo "$VM_NAME is already running"
    else
        echo "Starting VM "
        $VBOX startvm "$VM_NAME" --type headless
        echo "Allow time to let the OS boot..."
        sleep 45
    fi
fi