#!/bin/bash
# This script will shell into an OMERO.VM

KEY="omerovmkey"
USER="omero"
HOST="localhost"
PORT="2222"
OPTIONS="StrictHostKeyChecking=no"

BIN_HOME=`pwd`
OMERO_VM_HOME=`dirname $BIN_HOME`
KEY_HOME=$OMERO_VM_HOME/keys

ssh-keygen -R [localhost]:$PORT -f ~/.ssh/known_hosts
chmod 600 $KEY_HOME/$KEY

ssh -o $OPTIONS -i $KEY_HOME/$KEY -p $PORT $USER@$HOST