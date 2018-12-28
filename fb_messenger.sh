#!/bin/bash

#We load the variables
source "/home/$(whoami)/Documents/bash_scripts/.env";

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
	CONTENT='{"api_key": "'${API_KEY}'"';
	IMAGE_URL="https://www.nimrod-messenger.io/api/v1/image";
	MESSAGE_URL="https://www.nimrod-messenger.io/api/v1/message";

	# If the parameters have a Message we use the message URL
	[ ! -z "${MESSAGE}" ] && {
		CONTENT=''"$CONTENT"', "message": "'${MESSAGE}'"';
		NIMROD_URL=$MESSAGE_URL;
	}

	# If the parameters have a URL we use the image URL
	[ ! -z "${URL}" ] && { 
		CONTENT=''"$CONTENT"', "url": "'${URL}'"';
		NIMROD_URL=$IMAGE_URL;
	}

	CONTENT=''"$CONTENT"'}'
	echo $CONTENT;
	RES=$(curl -s -X POST -H "Content-Type: application/json" -d "$CONTENT" "$NIMROD_URL")
 
	if [ "$RES" == "OK" ]; then
		echo "Message Sent"
		exit 0;
	else
		echo "Error while sending message: $RES"
		exit 1;
	fi
fi
