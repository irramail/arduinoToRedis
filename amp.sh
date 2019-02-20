#!/bin/sh
while true
do
  abs=`read x < /dev/ttyUSB0; echo $x'0' | tr -d '\r\n-' | sed s/.*=.// `
  abs=`echo 0.0 + $abs | bc`
  tempread=`cat /sys/bus/w1/devices/28-0516a4fc12ff/w1_slave`
  c=`echo "scale=1; "\`echo ${tempread##*=}\`" / 1000" | bc`;
  d=`date "+%Y-%m-%d"`
  t=`date "+%s"`
  #echo "$d $t $abs"
  redis-cli -h 192.168.9.9 append "all" "{\"t\":$t,\"a\":\"$abs\",\"c\":"$c"0}," >/dev/null 2> /dev/null
  sleep 59
done
