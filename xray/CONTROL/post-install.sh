#!/bin/sh

printf "post start\n" >> $LOGGING
APKG_PKG_DIR=/usr/local/AppCentral/xray-docker
XRAY_FOLDER=/share/Docker/$APKG_PKG_NAME
LOGGING=$XRAY_FOLDER/log.txt
UUID=(curl -i https://www.uuidgenerator.net/api/version1)

printf "IP1\n" >> $LOGGING
printf "$AS_NAS_INET4_IP1\n" >> $LOGGING
printf "IP2\n" >> $LOGGING
printf "$AS_NAS_INET4_IP2\n" >> $LOGGING
printf "ADDR_0\n" >> $LOGGING
printf "$AS_NAS_INET4_ADDR_0\n" >> $LOGGING
printf "UUID\n" >> $LOGGING
printf "$UUID\n" >> $LOGGING

case "$APKG_PKG_STATUS" in

	install)
		# post install script here
		printf "post-install\n" >> $LOGGING
		printf "docker compose start\n" >> $LOGGING
		docker-compose up -d
		printf "docker compose done\n" >> $LOGGING

		printf "create config.json start\n" >> $LOGGING
		cat > $XRAY_FOLDER/config.json <<EOF
    {
      "inbounds": [{
        "port": 9000,
        "protocol": "vmess",
        "settings": {
          "clients": [
            {
              "id": $UUID
            }
          ]
        }
      }],
      "outbounds": [{
        "protocol": "freedom",
        "settings": {}
      }]
    }
    EOF
		printf "create config.json done\n" >> $LOGGING
		;;
	upgrade)
	  printf "pre-upgrade\n" >> $LOGGING
		# post upgrade script here (restore data)
		# cp -af $APKG_TEMP_DIR/* $APKG_PKG_DIR/etc/.
		;;
	*)
		;;

esac

printf "post-install end\n" >> $LOGGING

exit 0
