#!/bin/bash
 for ip in {1..254};
 do
  hping3 -S -p $2 -c 1  $1.$ip 2> /dev/null | grep "flags=SA";
 done
