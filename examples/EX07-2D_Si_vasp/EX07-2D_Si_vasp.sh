#!/bin/sh

while true; do
   date >> log 
   USPEX -r >> log
   sleep 300
done
