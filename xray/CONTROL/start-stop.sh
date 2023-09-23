#!/bin/sh

XRAY_FOLDER=/share/Docker/$APKG_PKG_NAME
LOGGING=$XRAY_FOLDER/log.txt

echo "start-stop"

printf "start\n" >> $LOGGING
CONTAINER_NAME=Xray
printf "Container running\n" >> $LOGGING
printf "$1\n" >> $LOGGING

case "$1" in
    start)
        echo "Start $CONTAINER_NAME container..."
		docker start $CONTAINER_NAME  >> $LOGGING
        sleep 6 
                        
        ;;
    stop)
    	echo "Stop $CONTAINER_NAME container..."
    	docker stop $CONTAINER_NAME
    	sleep 6
        ;;
    reload)
    	echo "Reload $CONTAINER_NAME container..."
    	docker stop  $CONTAINER_NAME
    	sleep 6
    	docker start $CONTAINER_NAME
    	sleep 6
        ;;
    *)
        echo "Usage: $0 {start|stop|reload}"
        exit 1
        ;;
esac
exit 0
