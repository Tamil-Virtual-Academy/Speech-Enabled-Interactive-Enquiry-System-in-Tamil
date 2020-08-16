<?php
session_start();

$mysid = session_id();

$file = fopen("beginsession.txt","w");
// exclusive lock
if (flock($file,LOCK_EX))
{
    fwrite($file, $mysid);
    flock($file,LOCK_UN);
}
else
{
    # Something's wrong with setting up the session
    $mysid = "error";
}
fclose($file);

# TODO: Wait till the master_trigger.sh file reads this thing. I'll it has read it when the beginsession.txt is empty
while (!file_exists("agri_$mysid/ready.txt")) sleep(1);

echo $mysid;
?>
