#!/usr/bin/bash

echo "" > ../start.txt
while true; do
    to_do=`cat ../start.txt`
    #to start
    if [ "$to_do" == 110 ]; then
    	echo "" > ../start.txt
        tcsh scripts/enquiry_sys lists/ques_rec_map lists/questions_list lists/ans_map lists/answers_list lists/answers_list_ext lists/number_map lists/kw_trans_utf8_map lists/ans_ques
#    #to kill values
#    elif [ "$to_do" == 120 ]; then
#    	kill $(ps aux | grep enquiry_system.sh | head -1 | awk '{print $2}')
#    	echo "" > ../start.txt
#    #to restart
#    elif [ "$to_do" == 130 ]; then
#    	echo "" > ../start.txt
#    	tcsh scripts/enquiry_sys lists/ques_rec_map lists/questions_list lists/ans_map lists/answers_list lists/answers_list_ext lists/number_map lists/kw_trans_utf8_map
#    #wait until there is some input in start.txt file
    else
		echo "listening for input"
		sleep 1 # in seconds
    fi
done
