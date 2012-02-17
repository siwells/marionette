#!/bin/bash

export VM_NAME=${VM_NAME:-"$1"}
export VM_NAME=${VM_NAME:-"omerovm"}

set -e -u
#set -x # DEBUG TRACE

echo "Copying scripts to $VM_NAME"
bash upload.sh

echo "ssh : executing the driver script (driver.sh) on $VM_NAME"
bash connect.sh  << EOF
    bash /home/omero/driver.sh
EOF