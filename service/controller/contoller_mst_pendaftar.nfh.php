<?php
//==============================================================================================================================
$name_sp = base64_decode($namesp); // JANGAN DI UBAH
//==============================================================================================================================

$query = "CALL ".$name_sp."($param_sp)";
$result = $db->prepare($query);
$result->execute($param_kiriman);

//==============================================================================================================================

if($whattodo == 's801cda9c0408e05b4c359ae69ad22758_1' || $whattodo == 'g801cda9c0408e05b4c359ae69ad22758_1'
|| $whattodo == 's801cda9c0408e05b4c359ae69ad22758_2'|| $whattodo == 'g801cda9c0408e05b4c359ae69ad22758_2')
{
  $return_arr['data'] = array();
  while ($row = $result->fetch(PDO::FETCH_OBJ)) {
    $row_array['N1'] = $row->id_pendaftar;
    $row_array['N2'] = $row->nama_lengkap;
    $row_array['N3'] = $row->jenis_kelamin;
    $row_array['N4'] = $row->status_pernikahan;
    $row_array['N5'] = $row->pendidikan;
    $row_array['N6'] = $row->pekerjaan;
    $row_array['N7'] = $row->usia;
    $row_array['N8'] = $row->no_hp;
    $row_array['N9'] = $row->alamat;
    $row_array['N10'] = $row->kriteria_status_pernikahan;
    $row_array['N11'] = $row->kriteria_pendidikan;
    $row_array['N12'] = $row->kriteria_pekerjaan;
    $row_array['N13'] = $row->kriteria_usia;
    $row_array['N14'] = $row->kriteria_jenis_kelamin;

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
