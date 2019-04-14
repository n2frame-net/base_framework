<?php
/*
FILE INI UNTUK MENDAFTAR MENU BARU.
APA BILA INGIN MENAMBAH MENU BARU,
MAKA HARUS DI DAFTARKAN KE FILE INI TERLEBIH DAHULU
DI PANGGIL PADA SAAT KIRIMAN DAN BALIKAN DATA
*/

include_once 'config/db_connection.php';
include_once 'model/NNclass.php';

try{
    //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX BEGIN : JANGAN DI UBAH ! XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

    //========================= BEGIN : VARIABLE GLOBAL =====================================================================
    $database = new Connection();
    $db = $database->openConnection();
    $NN = new NNclass();
    $watermark = (isset($_POST['watermark']) ? $_POST['watermark'] : '');
    $controller = (isset($_POST['controller']) ? $_POST['controller'] : '');
    $whattodo = (isset($_POST['whattodo']) ? $_POST['whattodo'] : '');
    $namesp = (isset($_POST['namesp']) ? $_POST['namesp'] : '');
    $id_user = (isset($_POST['user']) ? $_POST['user'] : '');
    $id_group = (isset($_POST['group']) ? $_POST['group'] : '');
    $cadangan1 = (isset($_POST['cadangan1']) ? $_POST['cadangan1'] : '');
    $cadangan2 = (isset($_POST['cadangan2']) ? $_POST['cadangan2'] : '');
    $cadangan3 = (isset($_POST['cadangan3']) ? $_POST['cadangan3'] : '');
    $cadangan4 = (isset($_POST['cadangan4']) ? $_POST['cadangan4'] : '');
    $max_param = 100; // MAXIMAL PARAMETER UNTUK DI KIRIM KE SP
    // //========================= END : VARIABLE GLOBAL =======================================================================

    // //========================= BEGIN : KIRIMAN DARI DEPAN ==================================================================
    $param_sp = $NN->createParam($max_param, $watermark, $controller, $whattodo, $namesp, $id_user, $id_group, $cadangan1, $cadangan2, $cadangan3, $cadangan4)[0]; // TANDA TANYA
    $param_kiriman = $NN->createParam($max_param, $watermark, $controller, $whattodo, $namesp, $id_user, $id_group, $cadangan1, $cadangan2, $cadangan3, $cadangan4)[1]; // $_POST

    if(isset($_POST['isdelete'])){
    // AKAN OTOMATIS CEK JIKA ADA IMAGE YANG DIHAPUS
    $NN->deleteFile();
    }
    // AKAN OTOMATIS CEK APAKAH ADA UPLOAD FILE PADA VIEW
    $NN->uploadFile();
    
    // //========================= END : KIRIMAN DARI DEPAN ========================================================

    // //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX END : JANGAN DI UBAH ! XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


    // //========================= BEGIN : UNTUK NEMBAK SERVICE ==================================================================
	// SESSION START DI SET PADA SAAT SEBELUM MEMANGGIL CONTROLLER
    session_start();
    // HALAMAN LOGIN
    if($controller == '885910a2d735b4ba2504548ad8e58aeb') include $NN->nameFile("controller_sys_login");

    // MENU YANG DI KLIK HARUS MASUK SESSION LOGIN TERLEBIH DAHULU
    else if(isset($_SESSION['username']) && isset($_SESSION['password'])){
        //==============================================================================================================================
        $name_sp = 'sp_sys_menubar'; // JANGAN DI UBAH
        //==============================================================================================================================
        $query = "CALL ".$name_sp."(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        $result = $db->prepare($query);
        $result->execute(Array(0,1,'s801cda9c0408e05b4c359ae69ad22758_routes',3,$_SESSION['id_user'],$_SESSION['id_group'],6,7,8,9,10
        ,'-9',12,13,14,15,16,17,18,19));
        //==============================================================================================================================
        while ($row = $result->fetch(PDO::FETCH_OBJ)) {
          if($row->id_file != 1){
               $url = explode('!',$row->nameencrypt);
               $nameencrypt = $url[0];
               if($controller == $nameencrypt){
                 include $NN->nameFile(substr($row->namecontroller,0,-8));
               }
           }
        }
        //==============================================================================================================================
        if($controller == '2663da4add7faeda9d690079bd6167ff') include $NN->nameFile("controller_sys_menubar");
    }

    // APA BILA ADA YANG AKSES TANPA LOGIN
    else{
        echo "hayooo mau ngapain ???";
    }
    // //========================= END : UNTUK NEMBAK SERVICE ==================================================================

}catch (PDOException $e){
    echo "There is some problem in connection: " . $e->getMessage();
}
?>
