$(document).ready(function() {
	var oripw;
	var checkpw;

	$('#sign_pw').on('change', function() {
		oripwd = $('#sign_pw').val();
		if (oripwd.length < 6) {
			alert('패스워드는 6자리 이상 입력하세요.');
		}
	});

	$('#pwcheck').on('change', function() {
		checkpwd = $('#pwcheck').val();

		if (oripwd != checkpwd) {
			alert('패스워드가 다릅니다.');
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
						alert('중복된 아이디입니다.');
						$('#sign_id').val("");
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
						alert('중복된 닉네임입니다.');
						$('#sign_nickname').val("");
					}
			}
		})
	});

	$('#success').on('click', function(e) {
		if ($('#sign_id').val() == "" || $('#sign_pw').val() == "" || $("#sign_nickname").val()) {
			alert('정보입력을 전부 작성해주세요.!');
		} else {
			$('#signnew').submit();
		}
	});
});