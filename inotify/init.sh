#!/bin/sh

LOGFILE=/var/log/inotifywait.log
if [ -z "${MONITOR_PATH}" ]; then
   echo "You must setiing MONITOR_PATH in environment!!!"
   exit 0
fi

if [ ! -d "${MONITOR_PATH}" ]; then
   echo "Directory MONITOR_PATH not exists!!!"
   exit 0
fi

CMD_SCP=`which scp`
CMD_SED=`which sed`
echo "${CMD_SCP}"
echo "${MONITOR_PATH}"
echo "[Starting inotifywait...!!!]"
inotifywait -m $MONITOR_PATH \
    -e modify,attrib,moved_to,moved_from,move,create,delete,delete_self \
    --format '%T %w%f %e' \
    --timefmt '%F %T' | while read line; do

    STRDATE=${line%$MONITOR_PATH*}
    FIDX=${line#*/}
    FILEFULLPATH=/${FIDX%% *}
    EVENTNAME=${line##* }
    if [ -n "${EVENTNAME// /}" ]; then
       if [ $EVENTNAME="CREATE" -o $EVENTNAME="DELETE" ]; then
          if [ $EXT=".py" -a -f "$FILEFULLPATH" ]; then
             echo "Export tex02t ${STRDATE} ${EVENTNAME} ${FILEFULLPATH}" >> $LOGFILE
             echo "${CMD_SCP} -i ${EC2_PEM_FILE_PATH}/${EC2_PEM_FILE_NAME} ${EC2_ACCOUNT_SERVER}:$FILEFULLPATH $MONITOR_PATH " >> $LOGFILE
          fi
       fi
    fi
done
