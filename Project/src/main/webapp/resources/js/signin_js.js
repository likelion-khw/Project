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
		$('#image').trigger('click');
	});

	$('#image').on('change', function() {
		if (this.files && this.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#userimg').attr('src', e.target.result);
			}
			reader.readAsDataURL(this.files[0]);
		}

	});

	$('#success').on('click', function() {
		if ($('#sign_id').val() == "" || $('#sing_pw').val() == "") {
			alert('정보를 입력하세요');
		} else {
			$('#signnew').submit();
		}
	});
});