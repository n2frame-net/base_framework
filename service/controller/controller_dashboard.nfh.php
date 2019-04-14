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
    $row_array['N1'] = $row->id_agama;
    $row_array['N2'] = $row->nameagama;
    $row_array['N3'] = $row->description;

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
