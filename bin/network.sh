#!/bin/bash

export VMNAME=${VMNAME:-"$1"}
export VMNAME=${VMNAME:-"omerovm"}

set -e -u
set -x # DEBUG MODE

VBOX="VBoxManage --nologo"

$VBOX guestproperty enumerate $VMNAME | grep IP
