#!/bin/bash


pingsweep(){


 export IP = $2

 if  [ ! -z $IP  ]; then

    for host in {1..254}; do ping -c1 $IP.$host | grep "64 bytes"| cut -d ":" -f 1 | cut -d " " -f 4 > ips.txt ; done
    [ -s ips.txt ]; cat ips.txt
 fi

}


portscan(){

 if [ -s ips.txt ]; then

     echo "Fazendo o portscan!"
     echo "Insire as portas para teste (separados por vírgulas):"
     read ports
     echo $ports | tr ',' '\n' > ports_to_test.txt


     for TARGET in $( cat ips.txt ); do
     
        for ports_test in $( cat ports_to_test.txt ) ; do   bash -c "echo >/dev/tcp/$TARGET/$ports_test" 2>/dev/null && echo "Port $ports_test is open in $TARGET" ; done > portscan.txt

         done 
     [ -s portscan.txt ] && cat portscan.txt
     echo "Portscan completo ! "
 
 fi

}


help(){

 echo "Modo de uso:"
 echo ""
 echo "$0 -pingsweep 192.168.15"
 echo ""
 echo "$0 -portscan "
 echo ""
 echo "$0 -all 192.168.15 "
 echo ""
 echo "$0 -h"
 echo
 echo "$0 --help"
}



ARGS=$1

case  $ARGS in


"--help" | "-h")

 help
;;
"--pingsweep"|"-pingsweep")

pingsweep "$2"
;;
"-portscan"|"--portscan")
portscan
;;
"--all"|"-all")
pingsweep "$2"
portscan
;;

*)
help

;;

esac
    
