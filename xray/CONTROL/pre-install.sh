#!/bin/sh

APKG_PKG_DIR=/usr/local/AppCentral/xray-docker
XRAY_FOLDER=/share/Docker/$APKG_PKG_NAME
LOGGING=$XRAY_FOLDER/log.txt

if [ ! -d "$XRAY_FOLDER" ]; then
	mkdir "$XRAY_FOLDER"
fi

case "$APKG_PKG_STATUS" in

	install)
		# Make sure configuration directory exists
		printf "pre-install\n" >> $LOGGING

		# Make sure configuration directory exists
		if [ ! -d "$XRAY_FOLDER" ]; then
			mkdir "$XRAY_FOLDER"
		fi
		;;
	upgrade)
		# pre upgrade script
		printf "pre-upgrade\n" >> $LOGGING
		;;
	*)
		;;

esac

printf "pre-install end\n" >> $LOGGING

exit 0
