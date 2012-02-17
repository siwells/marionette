#!/bin/bash

export VMNAME=${VMNAME:-"$1"}
export VMNAME=${VMNAME:-"omerovm"}

set -e
set -u
set -x

VBOX="VBoxManage --nologo"
EXPORT_NAME="${VMNAME}_`date +%Y.%m.%d.%H.%M`.ova"
NUM_VMS=`$VBOX list vms | grep '"'$VMNAME'"' | wc -l`

if [[ NUM_VMS -lt 1 ]]
then
    echo "No VM called $VMNAME to export"
elif [[ NUM_VMS -gt 1 ]]
then
    echo "More than one VM called $VMNAME registered with VirtualBox"
elif [[ NUM_VMS -eq 1 ]]
then

    # Check VM not running
    ($VBOX list runningvms | grep '"'$VMNAME'"') && {
        echo "$VMNAME is currently running so stopping it before export"
        $VBOX controlvm "$VMNAME" poweroff && sleep 5
    }

    # Deal with extant ova at destination
    if [[ -e $EXPORT_NAME ]]; then
        echo "Removing extant ova called $EXPORT_NAME"
        rm -f $EXPORT_NAME
    fi

    # Finally, export the nominated VM to an OVA
    echo "Exporting VM to $EXPORT_NAME"
    $VBOX export $VMNAME --output $EXPORT_NAME
fi