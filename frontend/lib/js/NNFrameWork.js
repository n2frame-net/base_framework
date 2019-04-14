var whattodo = '';
var watermark = '';
var controller = "<?php echo (isset($_GET['n']) ? $_GET['n'] : '') ?>";
var namesp = '';
var kiriman = {};
var arrayToObject = {};

var sessionIduser = '';
var sessionIdgroup = '';
var sessionUsername = '';
var sessionNameemployees = '';



function NNFrameWork(){


    // DIGUNAKAN UNTUK NAMA FILE UPLOAD
  this.getHost = function(){
		var protocol = location.protocol;
		var slashes = protocol.concat("//");
		var host = slashes.concat(window.location.hostname);

		return host;
  };


    // DIGUNAKAN UNTUK NAMA FILE UPLOAD
  this.namefileupload = function(){
        var random1 = ((Math.random() *1000) +"").slice(-4);
        var random2 = ((Math.random() *1000) +"").slice(-2);
		var todayupload = NN.getToday();
		var uniqu = random1+''+todayupload.replace(/\//g, '')+''+random2;

		// MENGGUNAKAN RANDOM 4 BARIS DI AWAL, DDMMYYYY DAN 2 BARIS RANDOM DI AKHIR
		return uniqu;
  };



  this.getToday = function(){
		var obj_today = new Date();
		var dd = obj_today.getDate();
		var mm = obj_today.getMonth()+1; //January is 0!

		var yyyy = obj_today.getFullYear();
		if(dd<10){
		dd='0'+dd;
		}
		if(mm<10){
		mm='0'+mm;
		}
		var today = yyyy+'-'+mm+'-'+dd;
		return today;
  };


  this.backService = function (returnData){
    if(returnData == 'NPL'){
      returnData1 = 'kondisi ini gunanya untuk pengalihan';
    }else{
      returnData2 = returnData;
    }
  return returnData2;
  };

  this.callService = function (KIRIMAN){
	// UNTUK MENGHITUNG JUMLAH KIRIMAN
	// DIKURANG 10 KARENA ADA KIRIMAN YANG WAJIB/DISET SECARA DEFAULT
	// SEHINGGA TIDAK MASUK PARAMETER YANG CUSTOM
  // 'watermark',  'controller', 'whattodo', 'namesp', 'user', 'group'
  // 'cadangan1', 'cadangan2', 'cadangan3', 'cadangan4'
    var total_kiriman = Object.keys(KIRIMAN).length - 10;
    if(total_kiriman == max_param_sp){
        $.ajax({
         url:"service/NNGateway.php",
         method:"POST",
         async: false,
         data: KIRIMAN,
        //  dataType: 'json',
         //beforeSend: function(xhr){xhr.setRequestHeader('X-Test-Header', 'test-value');},
         success:function(returnData)
           {
        	    NN.backService(returnData);
           },
           error: function() {
                console.log('AWWW!');
            },
            progress: function(e) {
                if(e.lengthComputable) {
                    var pct = (e.loaded / e.total) * 100;
					//console.log(pct);
                    // $('#prog')
                    //     .progressbar('option', 'value', pct)
                    //     .children('.ui-progressbar-value')
                    //     .html(pct.toPrecision(3) + '%')
                    //     .css('display', 'block');
                } else {
                    // console.warn('Content Length not reported!');
                }
            }
        });
    }else{
        alert('jumlah kiriman melebihi batas.');
    }




  };


  this.uploadFile = function (FILENAME,RENAME,PATH){
    var name = document.getElementById(FILENAME).files[0].name;
    var form_data = new FormData();
    var ext = name.split('.').pop().toLowerCase();
    /*
    if(jQuery.inArray(ext, ['gif','png','jpg','jpeg']) == -1)
    {
        alert("Invalid Image File");
    }
    */
    var oFReader = new FileReader();
    oFReader.readAsDataURL(document.getElementById(FILENAME).files[0]);
    var f = document.getElementById(FILENAME).files[0];
    var fsize = f.size||f.fileSize;
    if(fsize > 2000000)
    {
        alert("Image File Size is very big");
    }
    else
    {
        form_data.append(FILENAME, document.getElementById(FILENAME).files[0]);
        form_data.append("rename", RENAME);
        form_data.append("path", PATH);
        //form_data.append("file_count", 1);
        $.ajax({
            url:'service/NNGateway.php',
            method:"POST",
            data: form_data,
            contentType: false,
            cache: false,
            processData: false,
            async: false,
            beforeSend:function(){
                //$('#uploaded_image').html("<label class='text-success'>Image Uploading...</label>");
            },
            success:function(data)
            {
                //$('#uploaded_image').html(data);
            }
        });
    }
  };

  this.deleteFile = function (FILENAME,PATH,FLAG){

        // AJAX request
        $.ajax({
            url: 'service/NNGateway.php',
            type: 'post',
            data: {namefile: FILENAME, path:PATH, isdelete:FLAG},
            success: function(response){
                // Changing image source when remove
                if(response == 1){
                    //$("#img_" + split_id[1]).attr("src","images/noimage.png");
                }
            }
        });
  };



  this.scrollTop = function(){
    $('html,body').animate({ scrollTop: 0 }, 'fast');
  };

  this.scrollPoint = function(){
    $('html, body').animate({ scrollTop: $('#mainRow').offset().top-500 }, 'fast');
  };

  this.scrollBottom = function(){
    $('html,body').animate({scrollTop: document.body.scrollHeight},'fast');
  };



  this.colorEmpty = function(){
    var color = '#f39c12';
    return color;
  };
  this.colorDefault = function(){
    var color = '#fff';
    return color;
  };
  this.colorDisabled = function(){
    var color = '#eee';
    return color;
  };


    this.formatCurrency = function (param) {
        param = (isNaN(param) ? 0 : param);
        value = param + '';
        value = (value.length > 0 ? value : 0);

        value += '';

        x = value.split('.');
        x1 = x[0];
        x2 = x.length > 1 ? '.' + x[1] : '';
        var rgx = /(\d+)(\d{3})/;
        while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + '.' + '$2');
        }
        hasil = x1 + x2;
        return hasil;
    };

  // DIGUNAKAN UNTUK INPUT TYPE KEYUP PARAM1 = EVENT, PARAM2 = 
  this.keyUpFormatCurrency = function (element, prefix){

  		angka = element.value;
  		var number_string = angka.replace(/[^,\d]/g, '').toString(),
  			split	= number_string.split(','),
  			sisa 	= split[0].length % 3,
  			rupiah 	= split[0].substr(0, sisa),
  			ribuan 	= split[0].substr(sisa).match(/\d{3}/gi);
  		if (ribuan) {
  			separator = sisa ? '.' : '';
  			rupiah += separator + ribuan.join('.');
  		}
  		rupiah = split[1] !== undefined ? rupiah + ',' + split[1] : rupiah;

  		element.value = (prefix === undefined ? rupiah : (rupiah ? prefix +''+ rupiah : ''));
  };

  this.removePoint = function (VALUE){
    var angka = VALUE.replace(/\./g,'');
    return angka;
  };

  this.hanyaAngka = function(evt) {
		  var charCode = (evt.which) ? evt.which : event.keyCode
		   if (charCode > 31 && (charCode < 48 || charCode > 57))

		    return false;
		  return true;
		}


  this.func_kiriman = function (){

    // BUAT OBJECT UNTUK KIRIMAN
    kiriman = {
        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX JANGAN DI UBAH !! XXXXXXXXXXXXXXXXXX
        'watermark'			: watermark,
        'controller'		: controller,
        'whattodo'			: whattodo,
        'namesp'	    	: namesp,
        'user'			    : sessionIduser,
        'group'			    : sessionIdgroup,
        'cadangan1'			: '',
        'cadangan2'			: '',
        'cadangan3'			: '',
        'cadangan4'			: '',
    };

    // MEMBUAT KEY OBJECT DENGAN ARRAY
    var arrTest = [];
    for(i=1; i<=max_param_sp; i++){
        arrTest.push(i);

    }

    // CONVERT ARRAY TO OBJECT
    objTest = {};
    for (var key of arrTest) {
        objTest[key] = '';
    }


    // PUSH OBJECT 1 - MAX_PARAM_SP
    Object.assign(kiriman, objTest);

  };


  // BEGIN : UNTUK PLASE WAIT
  this.pleaseWait = function(start) {
    var _this = this;
    if (start) {
      _this.construct();
      window.location.href = "#pleasewait";
    }else{
      window.location.href = "#";
	  }
  };

  this.construct = function() {
    var _this = this;
    var html = '<div id="pleasewait" class="modalDialog"><div><div class="loading-spinner"></div></div></div>';

    _this.appendHtml(document.body, html);
    _this.appendCss();
  };

  this.appendHtml = function(el, str) {
    var div = document.createElement('div');
    div.innerHTML = str;
    while (div.children.length > 0) {
      el.appendChild(div.children[0]);
    }
  };

  this.appendCss = function() {
    var css = '.modalDialog {position: fixed;font-family: Arial, Helvetica, sans-serif;top: 0;right: 0;bottom: 0;left: 0; background: rgba(0, 0, 0, 0.8);z-index: 99999;opacity:0; -webkit-transition: opacity 400ms ease-in; -moz-transition: opacity 400ms ease-in;transition: opacity 400ms ease-in; pointer-events: none;}  .modalDialog:target {opacity:1;pointer-events: auto;}  .modalDialog > div {width: 100%;position: relative;margin: 20% auto;}@-webkit-keyframes rotate-forever { 0% { -webkit-transform: rotate(0deg); -moz-transform: rotate(0deg); -ms-transform: rotate(0deg); -o-transform: rotate(0deg); transform: rotate(0deg); } 100% { -webkit-transform: rotate(360deg); -moz-transform: rotate(360deg); -ms-transform: rotate(360deg); -o-transform: rotate(360deg); transform: rotate(360deg); } } @-moz-keyframes rotate-forever { 0% { -webkit-transform: rotate(0deg); -moz-transform: rotate(0deg); -ms-transform: rotate(0deg); -o-transform: rotate(0deg); transform: rotate(0deg); } 100% { -webkit-transform: rotate(360deg); -moz-transform: rotate(360deg); -ms-transform: rotate(360deg); -o-transform: rotate(360deg); transform: rotate(360deg); } } @keyframes rotate-forever { 0% { -webkit-transform: rotate(0deg); -moz-transform: rotate(0deg); -ms-transform: rotate(0deg); -o-transform: rotate(0deg); transform: rotate(0deg); } 100% { -webkit-transform: rotate(360deg); -moz-transform: rotate(360deg); -ms-transform: rotate(360deg); -o-transform: rotate(360deg); transform: rotate(360deg); } } .loading-spinner { -webkit-animation-duration: 0.75s; -moz-animation-duration: 0.75s; animation-duration: 0.75s; -webkit-animation-iteration-count: infinite; -moz-animation-iteration-count: infinite; animation-iteration-count: infinite; -webkit-animation-name: rotate-forever; -moz-animation-name: rotate-forever; animation-name: rotate-forever; -webkit-animation-timing-function: linear; -moz-animation-timing-function: linear; animation-timing-function: linear; height: 30px; width: 30px; border: 8px solid #ffffff; border-right-color: transparent; border-radius: 50%; display: inline-block; }.loading-spinner { position: absolute; top: 50%; right: 0; bottom: 0; left: 50%; margin: -15px 0 -15px;}',
    head = document.head || document.getElementsByTagName('head')[0],
    style = document.createElement('style');
    style.type = 'text/css';

    if (style.styleSheet){
      style.styleSheet.cssText = css;
    } else {
      style.appendChild(document.createTextNode(css));
    }

    head.appendChild(style);
  };
  // END : UNTUK PLEASE WAIT


}