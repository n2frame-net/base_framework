<?php


class NNclass{

    private $directory = "controller/";
    private $nfh = ".nfh.php";

    public function nameFile($FILE){
         $namefile = $this->directory."".$FILE."".$this->nfh;
         return $namefile;
    }

    public function createParam($max_param, $watermark, $controller, $whattodo, $namesp, $id_user, $id_group, $cadangan1, $cadangan2, $cadangan3, $cadangan4){
        $param_kiriman = array($watermark, $controller, $whattodo, $namesp, $id_user, $id_group, $cadangan1, $cadangan2, $cadangan3, $cadangan4);
        $param_alias = array('?,?,?,?,?,?,?,?,?,?');

        //BEGIN : PERULANGAN KIRIMAN STRING VAR_X
        for ($x = 1; $x <= $max_param; $x++) {
            if(isset($_POST[$x])){
                $param_kiriman[] = $_POST[$x]; // PEMBENTUKAN PARAMETER MENGGUNKAN PUSH ARRAY
                $param_alias[] = '?'; // PEMBENTUKAN PARAMETER ALIAS
            }
        }
        //END : PERULANGAN KIRIMAN STRING  VAR_X
        $param_sp = implode(",",$param_alias); // COVERT ARRAY TO STRING
        return array($param_sp, $param_kiriman);
    }

    public function uploadFile(){
        // LOOPING UNTUK JUMLAH UPLOAD FILE PADA VIEW
    	for ($x = 1; $x <= 10; $x++) {
            if(isset($_FILES['form_main_insertupdate_fileupload_'.$x]["name"]) != ''){
                $test = explode('.', $_FILES['form_main_insertupdate_fileupload_'.$x]["name"]);
                $ext = end($test);
	              $name = $_POST["rename"];
	              $dir = $_POST["path"];
                $location = 'fileupload/'.$dir.'/'. $name;
                move_uploaded_file($_FILES['form_main_insertupdate_fileupload_'.$x]["tmp_name"], $location);
    		     }
        }
    }

    public function deleteFile(){
        $namefile = (isset($_POST['namefile']) ? $_POST['namefile'] : '');
        $path = (isset($_POST['path']) ? $_POST['path'] : '');
        $return_text = 0;
        $location = 'fileupload/' . $path . '/' . $namefile;
        // Check file exist or not
    		if(strlen($path) > 0){
    			if(file_exists($location)){
    				 // Remove file
    				 unlink($location);
    				 // Set status
    				 $return_text = 1;
    			}else{
    				 // Set status
    				 $return_text = 0;
    			}
    			//echo $return_text;
    		}
    }


}


?>
