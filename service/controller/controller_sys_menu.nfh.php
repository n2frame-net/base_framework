<?php
//==============================================================================================================================
$name_sp = base64_decode($namesp); // JANGAN DI UBAH
//==============================================================================================================================

$query = "CALL ".$name_sp."($param_sp)";
$result = $db->prepare($query);
$result->execute($param_kiriman);

//==============================================================================================================================

if($whattodo == 's801cda9c0408e05b4c359ae69ad22758_1' || $whattodo == 'i801cda9c0408e05b4c359ae69ad22758_1'
|| $whattodo == 'u801cda9c0408e05b4c359ae69ad22758_1'|| $whattodo == 'd801cda9c0408e05b4c359ae69ad22758_1')
{
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
    $row_array['N12'] = $row->isactivated;
    $row_array['N13'] = $row->orderinglv1;
    $row_array['N14'] = $row->orderinglv2;
    $row_array['N15'] = $row->isdashboard;

    $return_arr['data'][] = $row_array; //PUSH ARRAY
  }
}

else if($whattodo == 's801cda9c0408e05b4c359ae69ad22758_2')
{
  $return_arr['data'] = array();
  while ($row = $result->fetch(PDO::FETCH_OBJ)) {
    $row_array['N1'] = $row->id_menu;
    $row_array['N2'] = $row->namemenu;

    $return_arr['data'][] = $row_array; //PUSH ARRAY
  }
}

else if($whattodo == 's801cda9c0408e05b4c359ae69ad22758_3')
{
  $return_arr['data'] = array();
  while ($row = $result->fetch(PDO::FETCH_OBJ)) {
    $row_array['N1'] = $row->id_file;
    $row_array['N2'] = $row->nameview;

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
