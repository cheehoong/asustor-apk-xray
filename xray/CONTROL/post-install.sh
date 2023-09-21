#!/bin/sh

WEB_PORT=9000
APKG_PKG_DIR=/usr/local/AppCentral/xray-docker
XRAY_FOLDER=/share/Docker/$APKG_PKG_NAME
LOGGING=$XRAY_FOLDER/log.txt
#CURL='/usr/bin/curl'
RVMHTTP="https://www.uuidgenerator.net/api/version1"
CURLARGS="-i"

# you can store the result in a variable
UUID="$(curl $CURLARGS $RVMHTTP)"

printf "IP1\n" >> $LOGGING
printf "$AS_NAS_INET4_IP1\n" >> $LOGGING
printf "IP2\n" >> $LOGGING
printf "$AS_NAS_INET4_IP2\n" >> $LOGGING
printf "ADDR_0\n" >> $LOGGING
printf "$AS_NAS_INET4_ADDR_0\n" >> $LOGGING

case "$APKG_PKG_STATUS" in

	install)
		# post install script here
		docker-compose up -d

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

		;;
	upgrade)
		# post upgrade script here (restore data)
		# cp -af $APKG_TEMP_DIR/* $APKG_PKG_DIR/etc/.
		;;
	*)
		;;

esac

exit 0
