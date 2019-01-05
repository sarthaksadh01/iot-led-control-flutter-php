<?php
if(isset($_POST['state'])){
    $myfile = fopen("data.txt", "w") or die("error");
    $data=$_POST['state'];
    fwrite($myfile, $data);
    fclose($myfile);
 
}

if(isset($_GET['led'])){

    $myfile = fopen("data.txt", "r") or die("error");
    echo fread($myfile,filesize("data.txt"));
    fclose($myfile);
}


?>