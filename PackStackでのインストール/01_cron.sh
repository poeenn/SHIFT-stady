useradd openstack
passwd openstack 
#############パスワード入力（2回）

gpasswd -a openstack wheel


cat << EOT3 >> /etc/crontab 2>&1
  59 23 *  *  * root /sbin/shutdown -h now
EOT3
systemctl restart crond 

cat << EOT3 >> /etc/hosts 2>&1
150.95.186.218 controller
150.95.134.74 conpute
EOT3

#################controller#######################
cat << EOT4 > /etc/sysconfig/network-scripts/ifcfg-eth1 2>&1
TYPE="Ethernet"
BOOTPROTO="none"
IPADDR="192.168.100.1"
NETMASK="255.255.255.0"
DEVICE="eth1"
ONBOOT="yes"
EOT4

#################conpute#######################
cat << EOT4 > /etc/sysconfig/network-scripts/ifcfg-eth1 2>&1
TYPE="Ethernet"
BOOTPROTO="none"
IPADDR="192.168.100.2"
NETMASK="255.255.255.0"
DEVICE="eth1"
ONBOOT="yes"
EOT4



route add -net 192.168.100.0 netmask 255.255.255.0 eth1


systemctl stop NetworkManager
systemctl disable NetworkManager
systemctl restart network
systemctl enable network


