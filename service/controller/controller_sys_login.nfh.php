<?php
//==============================================================================================================================
$name_sp = 'sp_sys_login'; // DAPAT DI UBAH SESUAI KEBUTUHAN
//==============================================================================================================================

$query = "CALL ".$name_sp."($param_sp)";

//==============================================================================================================================

try {
    // BEGIN : EKSEKUSI QUERY
        $result = $db->prepare($query);
        $result->execute($param_kiriman);
        $data = $result->fetch(PDO::FETCH_ASSOC);
    // END : EKSEKUSI QUERY


    if($result->rowCount() >= 1) {
        // menyimpan data ke dalam session
        // session_start();
        $_SESSION['id_user'] = $data['id_user'];
        $_SESSION['id_member'] = $data['id_member'];
        $_SESSION['id_group'] = $data['id_group'];
        $_SESSION['fullname'] = $data['fullname'];
        $_SESSION['username'] = $data['username'];
        $_SESSION['password'] = $data['password'];
        $_SESSION['namegroup'] = $data['namegroup'];
        $_SESSION['description'] = $data['description'];
        $_SESSION['isactivated'] = $data['isactivated'];
        $_SESSION['profileimage'] = $data['profileimage'];
        echo "good";
    }else {
        echo "Username/Password is wrong";
    }
}
catch(PDOException $e) {
    echo $e->getMessage();
}

// CLOSE CONNECTION, KEGUNAAN :
// SUPAYA TIDAK ADA MALCIOUS SCRIPT YANG BISA MELIHAT DATA PRIVATE
// UNTUK ITU SETELAH EKSEKUSI QUERY LANGSUNG TUTUP KONEKSI
$db = $database->closeConnection();
?>
