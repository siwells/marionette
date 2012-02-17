The purpose of these scripts is to automate the process of building various OMERO virtual machines. There are several core use cases that we have tried to satisfy in developing these scripts, 
	(1) Low barrier to entry demonstration of the OMERO server and client components.
	(2) Easy scripted install that can form that basis of package management scripts.
	(3) Enable easy spawning of manager & worker nodes for distributed workflows, HPC, & Grid deployments of OMERO.

There are a number of scripts in the bin directory that you can use to work with OMERO virtual machines. These scripts enable you to easily:

	(1) Provision VMs
	(2) Manage Startup & Shutdown of VMs
	(3) Provide quick access to a shell on a specific VM

1. Retrieve the OMERO.VM app:
	$ git archive --remote=ssh://szwells@git.openmicroscopy.org/home/git/ome.git --format=tar HEAD:docs/install/VM > omerovmscripts.tar


Targets
=======

	1. Create a VM
	2. Setup SSH Keys for automatic login
	3. Install software prerequisites needed by OMERO
	4. Install omero


Examples
========

The vm target will provision a base virtual machine using a cloned vdi
	$ sh omerovm --vdi omero_2011.05.23_base.vdi --vm-name omerovm2 --target vm
	
The keys target will set up your vm for automated login using SSH keys. This means that you don't have to type a password each time log in and can take advantage of unsupervised setup:
	$ sh omerovm --vm-name omerovm2 --target keys
	
	$ sh omerovm --vm-name omerovm2 --target software
	
	$ sh omerovm --vm-name omerovm2 --target omero
	
You can now connect directly to your VM via ssh without needing to enter a password by executing the following:
	$ ./connect.sh 
	
	
Appendix 1 - Provisioning your own VDI, what is required for the omerovm scripts to work?
=========================================================================================
