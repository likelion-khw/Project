$(document).ready(function() {
	var oripw;
	var checkpw;

	$('#sign_pw').on('change', function() {
		oripwd = $('#sign_pw').val();
		if (oripwd.length < 6) {
			$('#pwdo_msg').html('6자리 이상 입력해주세요.').css({'color':'red','font-size':'10px'});
			$('.input-field.pwdo input[type=password].validate').css('border-bottom','1px solid red');
			$('.input-field.pwdo input[type=password].validate').css('box-shadow','0 1px 0 0 red');
			$('.input-field.pwdo .prefix').css('color','red');
			
		}else{
			$('#pwdo_msg').html('');
			$('.input-field.pwdo .prefix').css('color','blue');
			$('.input-field.pwdo input[type=password].validate').css('border-bottom','1px solid blue');
			$('.input-field.pwdo input[type=password].validate').css('box-shadow','0 1px 0 0 blue');
		}
	});

	$('#pwcheck').on('change', function() {
		checkpwd = $('#pwcheck').val();

		if($('#sign_pw').val() != ''){
		if (oripwd != checkpwd) {
			$('#pwdc_msg').html('패스워드가 다릅니다.').css({'color':'red','font-size':'10px'});
			$('.input-field.pwdc .prefix').css('color','red');
			$('.input-field.pwdc input[type=password].validate').css('border-bottom','1px solid red');
			$('.input-field.pwdc input[type=password].validate').css('box-shadow','0 1px 0 0 red');
			$(this).focus();
		}else{
			$('#pwdc_msg').html('');
			$('.input-field.pwdc .prefix').css('color','blue');
			$('.input-field.pwdc input[type=password].validate').css('border-bottom','1px solid blue');
			$('.input-field.pwdc input[type=password].validate').css('box-shadow','0 1px 0 0 blue');
			}
		}else{
			alert('패스워드를 먼저 입력하세요.');
			$(this).val('');
			$('sign-pw').focus();
		}

	});

	$('#img').on('click', function() {
		$('#sign_image').trigger('click');
	});

	$('#sign_image').on('change', function() {
		if (this.files && this.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#userimg').attr('src', e.target.result);
			}
			reader.readAsDataURL(this.files[0]);
		}

	});

	$('#sign_id').on('change',function(){
		var lable = $(this).next();
		var userid = $('#sign_id').val();
		
		$.ajax({
			url : "idcheck.whame",
			type : 'post',
			data : {
				'userid' : userid,
			},
			success : function(result) {
				if(result == 1)
					{
						$('#userid_msg').html('중복된 아이디').css({'color':'red','font-size':'10px'});
						$('.input-field.userid .prefix').css('color','red');
						$('.input-field.userid input[type=text].valid').css('border-bottom','1px solid red');
						$('.input-field.userid input[type=text].valid').css('box-shadow','0 1px 0 0 red');
						$('#sign_id').val("").focus();
					}
				else{
						$('#userid_msg').html('')
						$('.input-field.userid .prefix').css('color','blue');
						$('.input-field.userid input[type=text].valid').css('border-bottom','1px solid blue');
						$('.input-field.userid input[type=text].valid').css('box-shadow','0 1px 0 0 blue');
					}
			}
		})
	});

	$('#sign_nickname').on('change',function(){
		var nickname = $('#sign_nickname').val();
		$.ajax({
			url : "nncheck.whame",
			type : 'post',
			data : {
				'nickname' : nickname,
			},
			success : function(result) {
				if(result == 1)
					{
						$('#nickname_msg').html('중복된 닉네임').css({'color':'red','font-size':'10px'});
						$('.input-field.nickname .prefix').css('color','red');
						$('.input-field.nickname input[type=text].valid').css('border-bottom','1px solid red');
						$('.input-field.nickname input[type=text].valid').css('box-shadow','0 1px 0 0 red');
						$('#sign_nickname').val("").focus();
					}
				else{
						$('#nickname_msg').html('')
						$('.input-field.nickname .prefix').css('color','blue');
						$('.input-field.nickname input[type=text].valid').css('border-bottom','1px solid blue');
						$('.input-field.nickname input[type=text].valid').css('box-shadow','0 1px 0 0 blue');
					}
			}
		})
	});

	$('#success').on('click', function(e) {
		if ($('#sign_id').val() == "" || $('#sign_pw').val() == "" || $("#sign_nickname").val() == "") {
			alert('정보입력을 전부 작성해주세요.!');
		} else {
			$('#signnew').submit();
		}
	});
});
