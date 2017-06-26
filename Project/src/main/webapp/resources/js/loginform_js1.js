$(document).ready(function() {
	$('#login').on('click', function() {
		var userid = $('#userid').val();
		var pw = $('#pw').val();
		var idsave = $('#log').is(":checked");
		var msg;

		if (userid == "" || pw == "") {
			if (userid == "") {
				msg = "아이디를 입력하세요.";
			} else {
				msg = "패스워드를 입력하세요";
			}
			alert(msg);
		} else {
			$.ajax({
				url : 'login.whame',
				type : 'post',
				data : {
					'userid' : userid,
					'pw' : pw,
				},
				success : function(result) {
					if (result[1] == 0) {
						alert("해당 아이디는 없습니다.")
						$('#userid').val("");
						$('#pw').val("");
					} else if (result[1] == 1) {
						alert("패스워드가 다릅니다.")
						$('#userid').val(userid);
						$('#pw').val("");
					} else if (result[1] == 2) {
						$.ajax({
							url : 'success.whame',
							type : 'post',
							data : {
								'userid' : result[0].userid,
								'pw' : result[0].pw,
								'userimage' : result[0].userimage,
								'nickname' : result[0].nickname,
								'idsave' : idsave
							},
							success : function() {
								$(location).attr('href', '/whame');
							}

						})
					}
				}
			});
		}
	});
	
})