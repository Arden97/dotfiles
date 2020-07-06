#!/usr/bin/env bash
echo
running="kernel-"$(uname -r)
echo Current kernel: $running
others=$(rpm -q kernel) | sed "/$running/d;"
if [ ! -z $others ]
then
	echo Other kernels: $others
	echo                       
	while true; do
    		read -p "Do you wish to remove this kernels? " yn
    		case $yn in
        		[Yy]* ) dnf remove $others; break;;
        		[Nn]* ) exit;;
        		* ) echo "Please answer yes or no.";;
    		esac
	done
fi
