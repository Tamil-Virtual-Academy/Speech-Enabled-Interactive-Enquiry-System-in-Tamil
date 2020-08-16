<?php

// $uploaddir = '/var/www/html/agri/upload/';
// $uploadfile = $uploaddir . "myRecording.wav";
//
// move_uploaded_file($_FILES['file']['blob'], $uploadfile);

// pull the raw binary data from the POST array
$data = substr($_POST['data'], strpos($_POST['data'], ",") + 1);
// decode it
$decodedData = base64_decode($data);
// print out the raw data,
$filename = $_POST['fname'];
echo $filename;
// write the data out to the file
$fp = fopen("../wav/$filename", 'wb');
fwrite($fp, $decodedData);
fclose($fp);

?>
