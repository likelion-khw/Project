<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.signinform{
	width:40%;
}

@media only screen and (min-width : 321px) and (max-width : 992px) {
	.signinform {
		width:90%;
}
}
</style>
<div id="signin" class="modal modal-fixed-footer center-align signinform">
	<div class="modal-content">
		<form action="sign.whame" method="post" enctype="multipart/form-data" id="signnew">
		<h4>회원가입</h4>
		이미지 변경<br>
		<a href="javascript:;" id="img">
		<img class="circle" src="resources/img/user.png" style="width: 150px; height:150px" id="userimg"></a>
		<div class="row">
		      <div class="row">
		        <div class="input-field col s12">
		          <i class="material-icons prefix">account_circle</i>
		          <input id="sign_id" type="text" class="validate" name="userid">
         		  <label for="email">사용자 아이디</label>
		        </div>
		        <div class="input-field col s12">
		          <i class="material-icons prefix">grade</i>
		          <input type="text" class="validate" name="nickname" id="sign_nickname">
         		  <label for="nickname">닉네임</label>
		        </div>
		        <div class="input-field col s12">
		          <i class="material-icons prefix">https</i>
		          <input id="sign_pw" type="password" class="validate" name="pw">
		          <label for="pw">패스워드</label>
		        </div>
		        <div class="input-field col s12">
		          <i class="material-icons prefix">lock_outline</i>
		          <input id="pwcheck" type="password" class="validate">
		          <label for="pwcheck">패스워드확인</label>
		        </div>
		      </div>
		  </div>
		<input type="file" name="image" id="sign_image" style="display: none;">
		</form>
	</div>

	<div class="modal-footer">
		<a href="#!"
			class="modal-action modal-close btn">취소</a>
		<a href="#!" class="btn" id="success">확인</a> 
	</div>
</div>

<script type="text/javascript" src="resources/js/signin_js.js"></script>