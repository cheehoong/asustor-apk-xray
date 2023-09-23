#!/bin/sh

WEB_PORT=9000
APKG_PKG_DIR=/usr/local/AppCentral/xray-docker
XRAY_FOLDER=/share/Docker/$APKG_PKG_NAME
LOGGING=$XRAY_FOLDER/log.txt
#CURL='/usr/bin/curl'
RVMHTTP="https://www.uuidgenerator.net/api/version1"
CURLARGS="-s"

docker pull teddysun/xray:latest
printf "Completed docker pull\n" >> $LOGGING

# you can store the result in a variable
UUID="$(curl $CURLARGS $RVMHTTP)"

printf "UUID\n" >> $LOGGING
printf "$UUID\n" >> $LOGGING
printf "IP1\n" >> $LOGGING
printf "$AS_NAS_INET4_IP1\n" >> $LOGGING
printf "IP2\n" >> $LOGGING
printf "$AS_NAS_INET4_IP2\n" >> $LOGGING
printf "ADDR_0\n" >> $LOGGING
printf "$AS_NAS_INET4_ADDR_0\n" >> $LOGGING
printf "$APKG_PKG_STATUS\n" >> $LOGGING

case "$APKG_PKG_STATUS" in
	install)
	  printf "Start install\n" >> $LOGGING
		# post install script here

		# Make sure configuration directory exists
    FILE=$XRAY_FOLDER/config.json
    if test -f "$FILE"; then
      printf "$FILE exists." >> $LOGGING
    else
      printf "Start cat create config.json\n" >> $LOGGING
      cat > $XRAY_FOLDER/config.json <<EOF
      {
        "inbounds": [{'
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
	  fi
		;;
	upgrade)
		# post upgrade script here (restore data)
		# cp -af $APKG_TEMP_DIR/* $APKG_PKG_DIR/etc/.
		;;
	*)
		;;
esac
    printf "docker-compose\n" >> $LOGGING
docker-compose up -d
#docker run -d -p 9000:9000 --name xray --restart=always -v /etc/xray:/etc/xray teddysun/xray
#docker start Xray
    printf "End case\n" >> $LOGGING

#Always check if there is any images tag with none, and remove it.
oldim=$(docker images | grep teddysun/xray | grep none | awk '{print $3}')
echo $oldim

if [ ! -z $oldim ]; then
	docker rmi -f $oldim
fi

exit 0
