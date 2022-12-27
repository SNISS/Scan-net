#!/bin/bash

if ["$1" == ""] 

then
    echo "Modo de uso: ./ping-sweep.sh 192.168.0"

else

   for host in {1..254};

do
   ping -c1 $1.$host | grep "64 bytes"| cut -d ":" -f 1 | cut -d " " -f 4 > ips.txt;done


fi
