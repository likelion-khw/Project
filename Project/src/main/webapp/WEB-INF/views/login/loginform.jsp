<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
<style>
.loginform{
	width: 350px;
	padding-top: 7%;
}
.loginbtn{
	margin-bottom:20px;
}
.snslogin{
	margin-top:20px;
}
</style>
<div class="container loginform">
	<div class="center-align">
			<div name="header">
				<i class="large material-icons">account_circle</i>
			</div>
			<div name="input">
				<div class="input-field">
			      <input value="" id="userid" type="text" class="validate" name="userid">
			      <label class="active" for="userid">아이디</label>
			    </div>
				<div class="input-field">
			      <input id="pw" type="password" class="validate" name="pw">
			      <label class="active" for="pw">패스워드</label>
			    </div>
			</div>
			<div name="log">
				<input type="checkbox" id="log" />
				<label for="log">로그인유지</label> 
			</div><br>
			<div class="loginbtn">
				<input type="button" value="로그인" class="btn black" id="login" style="width:300px"><br>
			</div>
			<a href="">아이디&패스워드 찾기</a> / <a href="#signin">회원가입</a>
			<div class="snslogin">
				<input type="button" value="카카오톡 로그인" class="btn orange" id="login">
				<input type="button" value="페이스북 로그인" class="btn blue" id="login">
			</div>
	</div>
</div>

<script type="text/javascript">
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
									'userimage' : result[0].userimage
								},
								success : function() {
										$(location).attr('href','/whame');
									}
								
							})
						}
					}
				});
			}
		});
	})
</script>