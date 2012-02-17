#!/bin/bash
# delete VM

export VM_NAME=${VM_NAME:-"$1"}
export VM_NAME=${VM_NAME:-"omerovm"}

set -e -u
set -x # DEBUG TRACE

VBOX="VBoxManage --nologo"
BIN_HOME=`pwd`
NUM_VMS=`$VBOX list vms | grep '"'$VM_NAME'"' | wc -l`

if [[ NUM_VMS -lt 1 ]]
then
    echo "No active VM called $VM_NAME"
    exit 1
elif [[ NUM_VMS -gt 1 ]]
then
    echo "More than one VM called $VM_NAME registered with VirtualBox"
    exit 1
else
    RUNNING=`$VBOX list runningvms | grep '"'$VM_NAME'"' | wc -l`
    if [[ $RUNNING -eq 1 ]]
    then
        echo "Stopping $VM_NAME"
        bash $BIN_HOME/stop.sh
        sleep 10
    fi
    $VBOX unregistervm "$VMNAME" --delete
fi