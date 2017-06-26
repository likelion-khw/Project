<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
		Cookie[] cookies = request.getCookies();
		String userid = "";
		String userpw = "";
		String state = "";
		if(cookies != null){
			for(Cookie c : cookies){
				if(c.getName().equals("userid")){  
					userid = c.getValue();
				}
				else if(c.getName().equals("pw")){  
					userpw = c.getValue();
				}else if(c.getName().equals("state")){  
					state = c.getValue();
				}
			}
		}
	%>
<script type="text/javascript">
  window.fbAsyncInit = function() {
    FB.init({
      appId      : '1731028550530201',
      cookie     : true,
      xfbml      : true,
      version    : 'v2.8'
    });
		    FB.AppEvents.logPageView(); 
  };

	  (function(d, s, id) {
		  var js, fjs = d.getElementsByTagName(s)[0];
		  if (d.getElementById(id)) return;
		  js = d.createElement(s); js.id = id;
		  js.src = "//connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v2.9&appId=1731028550530201";
		  fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));
	  function facebook_login(){
			FB.login(function(response){
				if(response.authResponse){
					var id = response.authResponse.userID;
					FB.api('/'+id+'?fields=email,name,picture{url}', function(response) {
						alert(JSON.stringify(response));
			  		    var userid= response.email;
			  		    if(userid == null){
			  		    	userid = response.id;
			  		    }
			  		    var nickname= response.name;
			  		    var userimage = response.picture.data.url;
			  		    var facebookauth = response.id;

			  		  $.ajax({
							url: 'facebook.whame',
							type: 'POST',
							data: {"userid" : userid,
									"facebookauth" : facebookauth,
									"nickname" : nickname,
									"userimage": userimage
									},
							success: function(result){
								$.ajax({
									url : 'success.whame',
									type : 'post',
									data : {
										'userid' : result.userid,
										'kakaoauth' : result.facebookauth,
										'userimage' : result.userimage,
										'nickname' : result.nickname
									},
									success : function() {
										$(location).attr('href', '/whame');
									}
								});
							}
						});
			  		    
			  		});
				}
			},{scope: 'email', auth_type: 'reauthenticate' });
		};

</script>
<style>
@import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css);
 .tabs .tab a{
	font-family:  'Nanum Pen Script';
	font-size: 20px;
 }
 
container.testmo{
	width: 60%;
}
.loginform2{
	width: 80%;
}
.loginbtn{
	margin-bottom:20px;
}
.snslogin{
	margin-top:20px;
}
.signinform{
	width:70%;
}
.modal{
	max-height: 200%;
	height: 90%;
}
.tabs div.indicator{
	background-color: #b0c4f3;
}

@media only screen and (min-width:1450px){
	.modal{
		width: 30%;
	}
	.snslogin img{
		width: 50%;
	}
	.signinform {
		margin-top:8%;
	}
}
@media only screen and (min-width : 900px) and (max-width : 1920px) {
	container.testmo{
		width: 40%;
	}
}
@media only screen and (min-width : 200px) and (max-width : 600px){
	.snslogin img{
		width: 80%;
	}
	.loginbtn input{
		width:100%;
	}
}
@media only screen and (min-width : 321px) and (max-width : 992px) {
	.signinform {
		width:90%;
	}
}

@media only screen and (min-height : 650px){
	.loginform2{
		margin-top: 8%;
	}
	.modal{
		height: 80%;
	}
}

</style>
	<div id="sign_login" class="modal testmo">
	     	<ul id="tabs-swipe-demo" class="tabs row">
			    <li class="tab col s6"><a class="active" href="#test-swipe-2" style="color:black;">로그인</a></li>
			    <li class="tab col s6"><a href="#test-swipe-1">회원가입</a></li>
			</ul>
			<a class="modal-close" style="color:black;"><i class="material-icons" style="color:red;margin-top:10px;margin-left:10px">close</i></a>
			<div class="container center-align signinform">
				<div id="test-swipe-1" class="col s12" style="margin-bottom:20px;">
					<form action="sign.whame" method="post" enctype="multipart/form-data" id="signnew">
						이미지 변경<br>
						<a href="javascript:;" id="img">
						<img class="circle" src="resources/img/user.png" style="width: 120px; height:120px" id="userimg"></a>
						<div class="row">
						        <div class="input-field userid col s12">
						          <i class="material-icons prefix">account_circle</i>
						          <input id="sign_id" type="text" class="validate" name="userid">
				         		  <label for="sign_id">사용자 아이디</label>
						        </div>
						        <div id="userid_msg">
						        </div>
						        <div class="input-field nickname col s12">
						          <i class="material-icons prefix">grade</i>
						          <input type="text" class="validate" name="nickname" id="sign_nickname">
				         		  <label for="nickname">닉네임</label>
						        </div>
						        <div id="nickname_msg">
						        </div>
						        <div class="input-field pwdo col s12">
						          <i class="material-icons prefix">https</i>
						          <input id="sign_pw" type="password" class="validate" name="pw">
						          <label for="pw">패스워드(6자리 이상)</label>
						        </div>
						        <div id="pwdo_msg">
						        </div>
						        <div class="input-field pwdc col s12">
						          <i class="material-icons prefix">lock_outline</i>
						          <input id="pwcheck" type="password" class="validate">
						          <label for="pwcheck">패스워드 확인</label>
						        </div>
						        <div id="pwdc_msg">
						        </div>
						  </div>
						<input type="file" name="image" id="sign_image" style="display: none;">
					</form>
					<a href="#!" class="btn blue" id="success" style="float:none;">가입</a> 
				</div>
			</div>
			<div class="container loginform2">
				<div id="test-swipe-2" class="col s12">
					<div class="center-align">
							<div name="header">
								<i class="large material-icons">account_circle</i>
							</div>
							<div name="input">
								<div class="input-field">
									<%if(state.equals("t")){ %>
							      		<input value="<%=userid %>" id="userid" type="text" class="validate" name="userid">
							      	<%}else{ %>
							      		<input value="" id="userid" type="text" class="validate" name="userid">
					      	 		<%} %>
							      <label class="active" for="userid">아이디</label>
							    </div>
								<div class="input-field">
									<%if(state.equals("t")){ %>
							    	  <input value="<%=userpw %>" id="pw" type="password" class="validate" name="pw" onkeyup="enterkey();">
							    	<%}else{ %>
							    	<input value="" id="pw" type="password" class="validate" name="pw" onkeyup="enterkey();">
							    	<%} %>
							      <label class="active" for="pw">패스워드</label>
							    </div>
							</div>
							<div name="log">
								<%if(state.equals("t")){ %>
								<input type="checkbox" id="log" checked="checked"/>
								 <%}else{ %>
								 <input type="checkbox" id="log" />
								 <%} %>
								<label for="log">로그인유지</label> 
							</div><br>
							<div class="loginbtn">
								<input type="button" value="로그인" class="btn black" id="login" style="width:80%"><br>
							</div>
							<a href="">아이디&패스워드 찾기</a> / <a href="#signin">회원가입</a>
							<div class="snslogin">
								<a id="login-btn" href="javascript:loginWithKakao()">
									<img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="40%"/>
								</a><br>
								<a href="#" onclick="facebook_login();"><img src="resources/img/facebook.png" width="40%"></a>
							</div>
					</div>
				</div>
			</div>
	</div>

<script type="text/javascript" src="resources/js/loginform_js1.js"></script>
<script type="text/javascript" src="resources/js/signin_js1.js">
</script>
<script type="text/javascript">
Kakao.init('f83177e46350e0d7ba18232a50b978ed');

function enterkey() {
    if (window.event.keyCode == 13) {
    	$('#login').trigger('click'); 
    }
}

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