#!/bin/bash

export VM_NAME=${VM_NAME:-"$1"}
export VM_NAME=${VM_NAME:-"omerovm"}

set -e -u
#set -x # DEBUG TRACE

BIN_HOME=`pwd`
OMERO_VM_HOME=`dirname $BIN_HOME`
SCRIPT_HOME=$OMERO_VM_HOME/scripts

VBOX="VBoxManage --nologo"
SSH_PF="2222"
SCP="scp -o StrictHostKeyChecking=no -i omerovmkey -P $SSH_PF"
SSH="ssh -2 -o StrictHostKeyChecking=no -i omerovmkey -p $SSH_PF -t"

##################
##################
# SCRIPT FUNCTIONS
##################
##################

function install_omero ()
{
	ssh-keygen -R [localhost]:$SSH_PF -f ~/.ssh/known_hosts
	chmod 600 ./omerovmkey
	#SCP="scp -2 -o NoHostAuthenticationForLocalhost=yes -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o CheckHostIP=no -o PasswordAuthentication=no -o ChallengeResponseAuthentication=no -o PreferredAuthentications=publickey -i omerovmkey -P $SSH_PF"
	echo "Copying scripts to VM"
	$SCP driver.sh omero@localhost:~/
	$SCP setup_userspace.sh omero@localhost:~/
	$SCP setup_postgres.sh omero@localhost:~/
	$SCP setup_environment.sh omero@localhost:~/
	$SCP setup_omero.sh omero@localhost:~/
	$SCP setup_omero_daemon.sh omero@localhost:~/
	$SCP setup_dhcp_daemon.sh omero@localhost:~/
	$SCP omero-init.d omero@localhost:~/
	$SCP renewdhcp-init.d omero@localhost:~/
	echo "ssh : exec driver.sh"
	#$SSH omero@localhost 'bash /home/omero/driver.sh'
	sleep 10
	
	echo "ALL DONE!"
}

####################
####################
# SCRIPT ENTRY POINT
####################
####################

bash $BIN_HOME/import_ova.sh
bash $BIN_HOME/start.sh
#install_omero
#bash export_ova.sh