### BEGIN INIT INFO
# Provides:          renewdhcp
# Required-Start:    $all
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:
# Short-Description: Ensure have an IP address from VirtualBox DHCP server
# Description:       Releases & renews the IP lease from the VirtualBox DHCP server
### END INIT INFO

NATIP="10.0.2.15"

getnet()
{
   IP=`ifconfig eth0 | grep 'inet ' | awk '{print $2}' | sed 's/addr://'`
}

getnet
echo $IP

if [ "$IP" = "$NATIP" ]
then
    echo "HURRAH! IP address correctly allocated by VirtualBox"
    exit
else
    echo "No IP address allocated by VirtualBox"
    echo "Releasing & renewing DHCP lease to force IP allocation from the VirtualBox DHCP server"
    dhclient -r
    dhclient eth0
    getnet
    echo $IP
fi
