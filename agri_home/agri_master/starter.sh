#!/bin/tcsh
# To be run by the master_trigger.sh file.
# Assuming pwd to be ../

cd $1/enquiry_system
scripts/enquiry_sys lists/ques_rec_map lists/questions_list lists/ans_map lists/answers_list lists/answers_list_ext lists/number_map lists/kw_trans_utf8_map lists/ans_ques

# Begin Cleanup code. Comment it out if it causes any problems :)
cd ../../
rm -rf $1
# End Cleanup code
