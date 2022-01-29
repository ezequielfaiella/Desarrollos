#!/bin/bash
#~ sudo modprobe nf_conntrack_pptp
#~ exit

for module in nf_nat_pptp nf_conntrack_pptp nf_conntrack_proto_gre
do 
	modprobe $module
done
