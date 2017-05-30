$(document).ready(function() {

	$('#login').on('click', function() {
		var userid = $('#userid').val();
		var pw = $('#pw').val();
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
								'nickname' : result[0].nickname
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

	Kakao.init('676bc5e5aca1030f2c233ff8f3655485');
	localStorage.removeItem('userid');
	
	Kakao.Auth.createLoginButton({
		
		container : '#kakao-login-btn',
		success : function(authObj) {
				if (typeof (localStorage) == 'undefined') { // 브라우저 지원 안될 시
					alert("not support 'localStorage");
					$(location).attr('href', '/login.whame');
				}
				
			localStorage.setItem('sessionTimeout', authObj.expires_in);
			localStorage.setItem('userid', authObj.access_token);
	
			Kakao.API.request({
				url: '/v1/user/me',
				success: function(res){
					alert(res.properties.nickname+"님 환영합니다");
					var kakaoLoginId = res.id;
				
						$.ajax({
							url: 'kakao.whame',
							type: 'POST',
							data: {"userid" : kakaoLoginId},
							success: function(result){
								if(result==2){
								$(location).attr('href', '/whame');
								} else {
									alert("실패");
									$(location).attr('href', '/login.whame');
								}
							}
						});
				},
				
				fail: function(error){
					alert("실패");
					alert(JSON.stringify(error));
					$(location).attr('href', '/login.whame');
				}
			});
		}, //Auth
	
		fail : function(err) {
			alert("실패")
			alert(JSON.stringify(err));
			$(location).attr('href', '/login.whame');
		}
	});
		
	
})// jquery