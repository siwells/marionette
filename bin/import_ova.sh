#!/bin/bash

export VM_NAME=${VM_NAME:-"$1"}
export VM_NAME=${VM_NAME:-"omerovm"}

set -e -u
set -x # DEBUG TRACE

VBOX="VBoxManage --nologo"
BIN_HOME=`pwd`
OMERO_VM_HOME=`dirname $BIN_HOME`
SCRIPT_HOME=$OMERO_VM_HOME/scripts
OVA_BASE_REPO=$OMERO_VM_HOME/ova/base
OVA_NAME="$VM_NAME.ova"
NUM_VMS=`$VBOX list vms | grep '"'$VM_NAME'"' | wc -l`
echo $NUM_VMS

if [[ NUM_VMS -gt 0 ]]
then
    echo "More than one VM called $VM_NAME registered with VirtualBox"
    # If VM with same name running stop it
    ($VBOX list runningvms | grep '"'$VM_NAME'"') && {
        echo "$VM_NAME is currently running so stopping it"
        $VBOX controlvm "$VM_NAME" poweroff
    }

    # then delete it
    echo "Deleting VM called $VM_NAME"
    $VBOX unregistervm $VM_NAME --delete
fi

# Now do the import
echo "Importing $OVA_NAME into VM called $VM_NAME"
$VBOX import $OVA_BASE_REPO/$OVA_NAME --options keepallmacs