 <!-- #####################################################################
 #
 #   Project       : NNFrame
 #   Author        : Nico Purnama Latena
 #   Version       : 0.0.7
 #   Created       : 01/01/2017
 #   Finish   	   : 01/01/2020
 #
 ##################################################################### -->



<?php
//jika session username belum dibuat
if (empty($_SESSION['username']) && empty($_SESSION['password'])){
	//redirect ke halaman login
	header('location:./');
}
?>


<!DOCTYPE html>
<html>

<head>
		<meta charset="UTF-8">
		<meta name="description" content="N2FRAME, NNFRAME" >
		<meta name="author" content="Nico Latena">
		<title>N2FRAME</title>
		<!-- Tell the browser to be responsive to screen width -->
		<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
		<!-- Bootstrap 3.3.7 -->
		<link rel="stylesheet" href="frontend/bower_components/bootstrap/dist/css/bootstrap.min.css">
		<!-- Font Awesome -->
		<link rel="stylesheet" href="frontend/bower_components/font-awesome/css/font-awesome.min.css">
		<!-- Ionicons -->
		<link rel="stylesheet" href="frontend/bower_components/Ionicons/css/ionicons.min.css">
		<!-- DataTables -->
		<link rel="stylesheet" href="frontend/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">

		<!-- Select2 -->
		<link rel="stylesheet" href="frontend/bower_components/select2/dist/css/select2.min.css">
		
		
        <!-- bootstrap datepicker -->
        <link rel="stylesheet" href="frontend/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">


	  <!-- iCheck for checkboxes and radio inputs -->
	  <link rel="stylesheet" href="frontend/plugins/iCheck/all.css">

		<!-- Theme style -->
		<link rel="stylesheet" href="frontend/dist/css/AdminLTE.min.css">


		<!-- AdminLTE Skins. Choose a skin from the css/skins
		   folder instead of downloading all of them to reduce the load. -->
		<link rel="stylesheet" href="frontend/dist/css/skins/_all-skins.min.css">

		<!-- CUSTOM STYLE FRAMEWORK NNFrame -->
		<link rel="stylesheet" href="frontend/lib/css/NNstyle.css">

		<!-- jQuery 3 -->
		<script src="frontend/bower_components/jquery/dist/jquery.min.js"></script>
		
		
		<!-- jQuery AJAX Progress -->
		<script src="frontend/bower_components/jquery.ajax-progress/jquery.ajax-progress.js"></script>
		
        <!-- bootstrap datepicker -->
        <script src="frontend/bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>

		<!-- AdminLTE App -->
		<script src="frontend/dist/js/adminlte.min.js"></script>

		<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!-- WARNINGG : Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->

		<!-- Google Font -->
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">



	  <!-- CALL FRAMWORK GLOBAL -->
	  <script src="frontend/lib/js/NNFrameWork.js"></script>


		<script type='text/javascript'>
			var NN = new NNFrameWork(); // GET OBJECT NNFRAMWORK
			var urlparam = "<?php echo (isset($_GET['n']) ? $_GET['n'] : ''); ?>";
			var urlparamsplit = urlparam.split('!');
			

			//Script Redirect CTRL + U
			function redirectCU(e) {
			  if (e.ctrlKey && e.which == 85) {
			    window.location.replace(NN.getHost());
					// alert('mau ngapain ya klik ctrl+U ????')
			    return false;
			  }
			}
			//document.onkeydown = redirectCU;

			//Script Redirect Klik Kanan

			function redirectKK(e) {
			  if (e.which == 3) {
			    //window.location.replace("https://mastamvan.blogspot.com/");
					alert('Mohon maaf, klik kanan tidak berfungsi pada halaman ini')
			    return false;
			  }
			}
			//document.oncontextmenu = redirectKK;


				// DEKLARASI SESSION  PADA VARIABLE JAVASCRIPT
				// WAJIB ADA
				sessionIduser = "<?php echo $_SESSION['id_user']; ?>";
				sessionUsername = "<?php echo $_SESSION['username']; ?>";
				sessionIdgroup = "<?php echo $_SESSION['id_group']; ?>";
				sessionNamegroup = "<?php echo $_SESSION['namegroup']; ?>";
				sessionFullname = "<?php echo $_SESSION['fullname']; ?>";
				sessionImage = "<?php echo $_SESSION['profileimage']; ?>";
				
	            var urlsessionimageuser = 'service/fileupload/imageuser/';

		</script>

</head>


<!--=======================================================================================================================================
===================================================== BEGIN : HALAMAN FILE UTAMA ==========================================================
========================================================================================================================================-->
<!-- SIDEBAR TAMPIL DI AWAL TAPI KECIL -->
<!-- <body class="hold-transition skin-black-light sidebar-collapse sidebar-mini"> -->
<!-- SIDEBAR TAMPIL DI AWAL -->
<body class="hold-transition skin-black-light sidebar-mini">
<!--	SIDEBAR HIDDEN -->
<!-- <body class="hold-transition skin-black-light sidebar-collapse"> -->

<div class="wrapper">
  <!--=======================================================================================================================================
  ===================================================== BEGIN : SECTION 1 : HEADER ==========================================================
  ========================================================================================================================================-->
  <?php
    include "frontend/view/html/support/header.html";
    include "frontend/view/html/support/sidebar.html";
  ?>
  <!--=======================================================================================================================================
  ===================================================== END : SECTION 1 : HEADER ==========================================================
  ========================================================================================================================================-->

    <!--=======================================================================================================================================
    ===================================================== BEGIN : SECTION 2 : CONTEN IN VIEW  =================================================
    ========================================================================================================================================-->

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
            <?php
                include "frontend/portalMenu.php";
            ?>
		</div>
        <!-- /.content-wrapper -->
    <!--=======================================================================================================================================
    ===================================================== END : SECTION 2 : CONTEN IN VIEW  =================================================
    ========================================================================================================================================-->

  <!--=======================================================================================================================================
  ===================================================== BEGIN : SECTION 3 : FOOTER ==========================================================
  ========================================================================================================================================-->
  <?php
    include "frontend/view/html/support/footer.html";
  ?>
  <!--=======================================================================================================================================
  ===================================================== BEGIN : SECTION 3 : FOOTER ==========================================================
  ========================================================================================================================================-->

</div>
<!-- ./wrapper -->
</body>
<!--=======================================================================================================================================
===================================================== END : HALAMAN FILE UTAMA ==========================================================
========================================================================================================================================-->



</html>


<script type="text/javascript">

function imageExists(url, callback) {
    var img = new Image();
    img.onload = function() { callback(true); };
    img.onerror = function() { callback(false); };
    img.src = url;
}

  
function validateImageURL(){
    var image_url = $('.session_image').attr('src');
    var imageUrl = image_url;
    
    imageExists(imageUrl, function(exists) {
        if(exists == false){
    	    $('.session_image').attr("src",urlsessionimageuser+'profile_default.png');
        }
    });
}

// HALAMAN LOAD SETELAH SEMUA DOM HTML SELESAI
$(document).ready(function(){
	//$('body').tooltip({ selector: '[data-toggle="tooltip"]' });

	$('.session_image').attr("src",urlsessionimageuser+''+sessionImage);
	$('.session_fullname').html(sessionFullname);
	$('.session_group').html(sessionNamegroup);
	$('.session_image').attr("alt",'no-img');
    validateImageURL();


});

$('.modal').on('hidden.bs.modal', function () {
	$("body").removeAttr("style");
})

//Flat blue color scheme for iCheck
// $('input[type="checkbox"].flat-blue, input[type="radio"].flat-blue').iCheck({
// 	checkboxClass: 'icheckbox_flat-blue',
// 	radioClass   : 'iradio_flat-blue'
// });
</script>


<!-- #####################################################################
#
#   Project       : NNFrame
#   Author        : Nico Purnama Latena
#   Version       : 0.0.7
#   Created       : 01/01/2017
#   Finish   	   : 01/01/2020
#
##################################################################### -->
