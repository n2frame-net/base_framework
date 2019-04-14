<?php

// INI UNTUK REDIRECT HTTP KE HTTPS
/*
if(empty($_SERVER['HTTPS']) || $_SERVER['HTTPS'] == "off"){
    $redirect = 'https://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
    header('Location: ' . $redirect);
    exit();
}
*/


session_start();
if (isset($_SESSION['username'])) {
  require "home.php";
}else{
  include "login.php";
}

?>
