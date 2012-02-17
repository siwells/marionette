#!/bin/bash

export VM_NAME=${VM_NAME:-"$1"}
export VM_NAME=${VM_NAME:-"omerovm"}

set -e -u
#set -x # DEBUG TRACE

VBOX="VBoxManage --nologo"
PASSWORD=${PASSWORD:-"omero"}
FORCE="false"
NUM_VMS=`$VBOX list runningvms | grep '"'$VM_NAME'"' | wc -l`

if [[ NUM_VMS -eq 0 ]]
then
    echo "No VM called $VM_NAME currently running"
    exit 1
else
    echo "Stopping $VM_NAME"
    bash connect.sh  << EOF
    echo $PASSWORD | /usr/bin/sudo -S shutdown -h now
EOF

    if $FORCE 
    then
        $VBOX controlvm "$VM_NAME" poweroff
    fi
fi