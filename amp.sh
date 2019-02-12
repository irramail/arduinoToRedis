#!/bin/sh
while true
do
  abs=`read x < /dev/ttyUSB0; echo $x'0' | tr -d '\r\n-' | sed s/.*=.// `
  abs=`echo 0.0 + $abs | bc`
  d=`date "+%Y-%m-%d"`
  t=`date "+%s"`
  #echo "$d $t $abs"
  redis-cli -h 192.168.9.9 append "$d" "{\"t\":$t,\"a\":\"$abs\"}," >/dev/null 2> /dev/null
  sleep 59
done

