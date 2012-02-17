#!/bin/bash

export VM_NAME=${VM_NAME:-"$1"}
export VM_NAME=${VM_NAME:-"omerovm"}

set -e -u
#set -x # DEBUG TRACE

VBOX="VBoxManage --nologo"

BIN_HOME=`pwd`
OMERO_VM_HOME=`dirname $BIN_HOME`
SCRIPT_HOME=$OMERO_VM_HOME/scripts
KEY_HOME=$OMERO_VM_HOME/keys
KEY="omerovmkey"
PORT="2222"
SCP="scp -2 -o NoHostAuthenticationForLocalhost=yes -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o CheckHostIP=no -o PasswordAuthentication=no -o ChallengeResponseAuthentication=no -o PreferredAuthentications=publickey -i $KEY_HOME/$KEY -P $PORT"
USER="omero"
HOST="localhost"
DEST=":~/"

ssh-keygen -R [localhost]:$PORT -f ~/.ssh/known_hosts
chmod 600 $KEY_HOME/$KEY
$SCP -r $SCRIPT_HOME $USER@$HOST$DEST