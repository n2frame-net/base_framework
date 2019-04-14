<?php
$db = $database->openConnection();
//==============================================================================================================================
$name_sp = 'sp_sys_menubar'; // JANGAN DI UBAH
//==============================================================================================================================

$query = "CALL ".$name_sp."($param_sp)";
$result = $db->prepare($query);
$result->execute($param_kiriman);

//==============================================================================================================================


if($whattodo == 's801cda9c0408e05b4c359ae69ad22758_menubar'){
  $return_arr['data'] = array();
  while ($row = $result->fetch(PDO::FETCH_OBJ)) {
    $row_array['N1'] = $row->id_menulv1;
    $row_array['N2'] = $row->id_menulv2;
    $row_array['N3'] = $row->id_file;
    $row_array['N4'] = $row->menulv1;
    $row_array['N5'] = $row->menulv2;
    $row_array['N6'] = $row->level;
    $row_array['N7'] = $row->description;
    $row_array['N8'] = $row->nameview;
    $row_array['N9'] = $row->namecontroller;
    $row_array['N10'] = $row->namesp;
    $row_array['N11'] = $row->nameencrypt;

    $return_arr['data'][] = $row_array; //PUSH ARRAY
  }
}
//==============================================================================================================================

// CLOSE CONNECTION, KEGUNAAN :
// SUPAYA TIDAK ADA MALCIOUS SCRIPT YANG BISA MELIHAT DATA PRIVATE
// UNTUK ITU SETELAH EKSEKUSI QUERY LANGSUNG TUTUP KONEKSI
$db = $database->closeConnection();

// display JSON data
$json = json_encode($return_arr);
echo $json;
//==============================================================================================================================
?>
