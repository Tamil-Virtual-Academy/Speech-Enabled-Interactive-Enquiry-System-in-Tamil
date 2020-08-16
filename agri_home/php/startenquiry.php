<?php

ini_set('display_errors', 1);
error_reporting(E_ALL);
// echo getcwd();

// exec('scripts/enquiry_sys lists/ques_rec_map lists/questions_list lists/ans_map lists/answers_list lists/answers_list_ext lists/number_map lists/kw_trans_utf8_map lists/ans_ques');
// exec('scripts/synth_recog lists/ques_rec_map lists/questions_list QA');

chdir("../enquiry_system/");
echo "Before starting\n";
exec('scripts/complete "நீங்கள் எந்த பயிரை பற்றி அறிய விரும்புகுறீர்கள்"');
// passthru('bash "./testpath"');
// exec('../festival/bin/festival -b festvox/build_clunits.scm \'(build_prompts "lists/text")\'');
echo "After starting\n";

// echo "Before starting\n";
// passthru('su -c "testsh" -s /bin/bash jjoysingh');
// echo "After starting\n";

// exec('scripts/sampleshell.sh test');

?>
