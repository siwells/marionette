#!/bin/bash

set -e -u -x

PASSWORD=${PASSWORD:-"omero"}

echo $PASSWORD | sudo -S cp /home/omero/renewdhcp-init.d /etc/init.d/
echo $PASSWORD | sudo -S chmod a+x /etc/init.d/renewdhcp-init.d
echo $PASSWORD | sudo -S update-rc.d -f renewdhcp-init.d remove
echo $PASSWORD | sudo -S update-rc.d -f renewdhcp-init.d defaults