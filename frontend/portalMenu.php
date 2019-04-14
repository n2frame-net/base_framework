<?php
/*
FILE INI UNTUK MENDAFTAR MENU BARU.
APA BILA INGIN MENAMBAH MENU BARU,
MAKA HARUS DI DAFTARKAN KE FILE INI TERLEBIH DAHULU
*/


//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX BEGIN : JANGAN DI UBAH ! XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
if(isset($_SESSION['id_user'])){
  include_once 'service/config/db_connection.php';
  //========================= BEGIN : VARIABLE GLOBAL =====================================================================
  $url = explode('!',(isset($_GET['n']) ? $_GET['n'] : ''));
  $namemenu = $url[0];
  $directory = "frontend/view/html/";
  $database = new Connection();
  $db = $database->openConnection();
  $name_sp = 'sp_sys_menubar'; // JANGAN DI UBAH
  // //========================= END : KIRIMAN DARI DEPAN ========================================================

  //==============================================================================================================================
  $query = "CALL ".$name_sp."(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
  $result = $db->prepare($query);
  $result->execute(Array(0,1,'s801cda9c0408e05b4c359ae69ad22758_routes',3,$_SESSION['id_user'],$_SESSION['id_group'],6,7,8,9,10
  ,'-9',12,13,14,15,16,17,18,19));
  //==============================================================================================================================
  if($namemenu != ''){
      while ($row = $result->fetch(PDO::FETCH_OBJ)) {
        if($row->id_file != 1){
             $url = explode('!',$row->nameencrypt);
             $nameencrypt = $url[0];
             if($namemenu == $nameencrypt){
               include $directory.$row->nameview;
             }
         }
      }
  }
  else{
    include $directory."view_dashboard.html";
    //  while ($row = $result->fetch(PDO::FETCH_OBJ)) {
    //     if($row->isdashboard == 1){
    //          include $directory.$row->nameview;
    //     }
    //   }
 }
  $db = $database->closeConnection();
  // TAMPILAN HOME SETELAH LOGIN BERDASARKAN HAK AKSES LOGIN
  //if($namemenu == 'c2e275d3fb6fc1b8fa54cd1472cb21ac'){
    //include $directory."view_dashboard.html";
  //}
}
// //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX END : JANGAN DI UBAH ! XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX



?>
