<?php
$maindir = getcwd();
chdir('../images/cropimages/');
$imagedir = getcwd();
$imagefiles = scandir($imagedir);
$numimages = count($imagedir);
// $output = '<img src='.$_GET["targetimagefile"].' onmouseover="bigImg(this)" onmouseout="normalImg(this)">';

// $imagereldir = "images/cropimages/";
// for ($x = 2; $x <= $numimages; $x++) {
//   $imagefile = $imagereldir.$imagefiles[2];
//   $output = '<img src="'.$imagefile.'" class="images">';
//   echo $output;
// }

echo json_encode($imagefiles);

// chdir($maindir)
?>
