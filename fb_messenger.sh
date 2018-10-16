#!/bin/bash

#We load the variables
source ".env"; 

API_KEY="$FB_KEY" #Para generar un nuevo API_KEY Accede a: https://www.nimrod-messenger.io/
while getopts "u:m:a:h" opt; do
	case "${opt}" in
		u) URL=${OPTARG};;
		m) MESSAGE=${OPTARG};;
		\?) echo "Invalid Option";;
		:)	echo "Option -$OPTARG requires an argument";;
		h)
			echo "Para mandar un mensaje"
			echo "Utilice los siguientes parametros:"
			echo -e "-m <message>  \t Text message to send"
			echo -e "-u <url>  \t Files URL to send"
			echo -e "-h \t\t To show this message"
			echo -e "-a <api key> \t Key of whom is going to receive this message"
			exit 0;
			;;
		a)
			API_KEY=${OPTARG}
	esac
done

if [ -z "${URL}" ] && [ -z "${MESSAGE}" ]; then
	echo "Usage: fb_messenger {(-m <message> | -u <URL>) [-a KEY] }"
	exit 0;
else
	RES=$(
			curl -s -X POST -H "Content-Type: application/json" -d '{ 
				"api_key": "'"${API_KEY}"'",
				"message": "'"${MESSAGE}"'",
				"url": "'"${URL}"'"
			}' "https://www.nimrod-messenger.io/api/v1/message"
		)
	if [ "$RES" == "OK" ]; then
		echo "Message Sent"
		exit 0;
	else
		echo "Error while sending message: ${RES}"
		exit 1;
	fi
fi