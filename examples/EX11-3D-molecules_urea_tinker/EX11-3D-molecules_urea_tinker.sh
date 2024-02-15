#!/bin/bash

JobLog=~/USPEX_JOB_LOG   #Output the script info (PATH/ID)
DoneTag=./USPEX_IS_DONE  #Exit when USPEX is done
ErrorTag=./still_running #Exit when USPEX has error
let Interval=120         #Time interval to run the script

now="$(date +'%H:%M %d/%m/%Y')"
SCRIPT=$(readlink -f "$0")
SCRIPTDIR=$(dirname "$SCRIPT")
printf "%-30s %12s %6d(PID) at %16s  per %3d seconds\n" \
"$SCRIPTDIR"  "$0"   "$$"  "$now" "$Interval" >> $JobLog

while [ ! -f $DoneTag ]; do
   if [ -f $ErrorTag ];
   then
       printf "%-30s %12s at %16s  ERROR\n" \
        "$SCRIPTDIR"  "$0"  "$now"  >> $JobLog
       break;
   else
       date >> log
       USPEX -r  >> log  #Your command to run USPEX
       sleep $Interval
   fi
   if [ -f $DoneTag ];
   then
       printf "%-30s %12s at %16s  DONE\n" \
       "$SCRIPTDIR"  "$0"  "$now"  >> $JobLog
   fi
done

