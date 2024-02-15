#!/bin/sh



while true; do
   date >> log 
   USPEX -o -r >> log
   sleep 300
done
