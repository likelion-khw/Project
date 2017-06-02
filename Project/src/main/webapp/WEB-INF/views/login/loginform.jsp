<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
<style>
.loginform{
	width: 350px;
	padding: 20px;
	margin-top:6%;
}
.loginbtn{
	margin-bottom:20px;
}
.snslogin{
	margin-top:20px;
}
</style>
<div class="container loginform z-depth-2">
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
				<a id="login-btn" href="javascript:loginWithKakao()">
					<img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="250"/>
				</a>
			</div>
	</div>
</div>

<script type="text/javascript" src="resources/js/loginform_js.js"></script>
<script type="text/javascript">
Kakao.init('f83177e46350e0d7ba18232a50b978ed');

function loginWithKakao(){
	Kakao.Auth.login({
		success : function(authObj) {
			Kakao.API.request({
				url: '/v1/user/me',
				success: function(res){
					var kakaoAuth = res.id;
					var userid = res.kaccount_email;
					var nickname = res.properties.nickname;
					var userimage = res.properties.profile_image;
						$.ajax({
							url: 'kakao.whame',
							type: 'POST',
							data: {"userid" : userid,
									"kakaoauth" : kakaoAuth,
									"nickname" : nickname,
									"userimage": userimage
									},
							success: function(result){
								$.ajax({
									url : 'success.whame',
									type : 'post',
									data : {
										'userid' : result.userid,
										'kakaoauth' : result.kakaoauth,
										'userimage' : result.userimage,
										'nickname' : result.nickname
									},
									success : function() {
										$(location).attr('href', '/whame');
									}
								});
							}
						});
				},
				
				fail: function(error){
					alert("실패");
					alert(JSON.stringify(error));
					$(location).attr('href', 'login.whame');
				}
			});
		}, //Auth
	
		fail : function(err) {
			alert("실패")
			alert(JSON.stringify(err));
			$(location).attr('href', '/login.whame');
		}
	});
}
</script>