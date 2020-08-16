#!/usr/bin/bash

echo "" > beginsession.txt
while true; do
    to_do=`cat beginsession.txt`
    #to start
    if [ $to_do ]; then
    	echo "" > beginsession.txt
    	cp -r agri_master agri_"$to_do"
        cd agri_"$to_do"/enquiry_system

        ./configure --with-fest-search-path=/home/jjoysingh/speech/festival/examples --with-hts-engine-search-path=/home/jjoysingh/speech/hts_engine_API-1.06/bin

        cd ../../

        echo "" > agri_"$to_do"/ready.txt

        # TODO Running in multi-proc now. Remove the & in the next line to make it work for single user
        agri_"$to_do"/starter.sh agri_"$to_do" &
    else
		echo "listening for input"
		sleep 1 # in seconds
    fi
done
