#!/usr/bin/env bash

#Load global variables
source '.env';

#Font weights
bold=${BOLD_FONT};
normal=${NORMAL_FONT};

#Information to show in the Help/Usage section
TITLE="${bold}OLD FILES DELETER${normal}";
MESSAGE="Deletes files/directories older than the specified time in the directory specified";
USAGE="Options:\n
    -h \t Shows this messages\n
    -d \t Specifies the days old of the files\n
    -m \t Specifies the minutes old of the files\n
    -s \t Specified the seconds old of the files\n
    -f \t Specifies the base dir to search the files\n
    -r \t Specified if the folders should be deleted";
EXAMPLE="Example: $0 -m 40 -d 10 -f ./testf/* -r";
curDate="$(date +%s)";

#Function called to show the Usage information
usage() {
    echo ${TITLE};
    echo ${MESSAGE};
    echo -e ${USAGE};
    echo ${EXAMPLE};
}

#Variable that stores the MAX date of a file/directory before to be deleted
TIME_BACK=0;

#Command to be called with older then specified time
PARAMS="rm -f";

#Route to search the files/directory
ROUTE="";

#We get all our data from the parameters/options
while getopts ':hd:m:s:f:r-:' opt; do
    case "$opt" in
        h) usage
        exit 0;
        ;;
        d) TIME_BACK="$(((${OPTARG} * 86400) + $TIME_BACK))";
        ;;
        m) TIME_BACK="$((($OPTARG * 60) + $TIME_BACK))";
        ;;
        s) TIME_BACK="$(($OPTARG + $TIME_BACK))";
        ;;
        r) PARAMS="${PARAMS}r";
        ;;
        f) ROUTE="${OPTARG}";
        ;;
        :)
        echo "The option requieres arguments";
        exit 1;
        ;;
        \?)
        echo "This is an invalid option";
        usage;
        exit 1;
        ;;
    esac
done

#Validate if there was any time specified
if [ $TIME_BACK == 0 ]; then
    echo "Specify at least a ${bold}day, minute or second${normal} to delete files.";
    echo "In that case you better use rm command"
    exit 1;
fi

#Validate if there is any file or directory
if [ $ROUTE == "" ]; then
    echo "Specify the file/directories where you want the script search the files/directories to delete";
    exit 1;
elif [ -d $ROUTE ]; then
    ROUTE="${ROUTE}/*";
fi

#Iterate through every file in the directory or file with a regular expression
for file in $ROUTE; do
     fDate="$(date -r $file +%s)";
     scnds="$(($curDate-$fDate))";
     if [ $scnds -ge $TIME_BACK ]; then
        $($PARAMS $file);
     fi
 done