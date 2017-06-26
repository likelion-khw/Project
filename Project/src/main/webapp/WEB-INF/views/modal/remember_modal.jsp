<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
.remember_modalform{
	width:300px;
}

.nick.modal{
	height: 40%;
}
.pass.modal{
	height: 55%;
}
</style>

<!-- 닉네임 변경 모달 -->
<div id="remember_nickname" class="nick modal remember_modalform center-align">
	<div class="modal-content">
		<h4>닉네임 변경</h4>
		닉네임<br>
		<input type="text" value="${memberVO.nickname}" style="width:150px;" id="re_nickname">
	</div>
	<div class="modal-footer">
		<a href="#!"
			class="modal-action btn" id="reload_nick" style="float:none;">변경</a>
		<a href="#!"
			class="modal-action modal-close btn" style="float:none;">취소</a>
	</div>
</div>

<!-- 패스워드 변경 모달 -->
<div id="remember_pw" class="pass modal remember_modalform center-align">
	<div class="modal-content">
		<h4>패스워드 변경</h4>
		변경 패스워드<br>
		<input type="password" style="width:150px;" id="re_pw"><br>
		패스워드 재확인<br>
		<input type="password" style="width:150px;" id="pw_check">
	</div>
	<div class="modal-footer">
		<a href="#!"
			class="modal-action btn" id="reload_pw" style="float:none;">변경</a>
		<a href="#!"
			class="modal-action modal-close btn" style="float:none;">취소</a>
	</div>
</div>

<script type="text/javascript">
$(document).ready(function() {

	//닉네임 변경
	$('#re_nickname').on('change',function(){
		var nickname = $('#re_nickname').val();
		$.ajax({
			url : "nncheck.whame",
			type : 'post',
			data : {
				'nickname' : nickname,
			},
			success : function(result) {
				if(result == 1)
					{
						$('#rem_nick_over').modal('open');
						$('#re_nickname').val("${memberVO.nickname}");
					}
			}
		})
	});

	$('#reload_nick').on('click',function(){
		var nickname = $('#re_nickname').val();
		if(nickname != "${memberVO.nickname}" && nickname != "")
			{
			$.ajax({
					url : "re_nickname.whame",
					type : 'post',
					data : {
							'nickname' : nickname
						},
					success : function(result){
							if(result == 1)
								{
									$(location).attr('href','remember.whame');
								}
						}
				})
			}else
				{
					$('#rem_nick_no').modal('open');
					$('#re_nickname').val("${memberVO.nickname}");
				}
		});

	
	//패스워드 변경
	
	var oripwd;
	var checkpwd;
	var msg;

	var keyA = false;
	var keyB = false;
	
	$('#re_pw').on('change', function() {
		oripwd = $('#re_pw').val();
		if (oripwd.length < 6) {
			alert('패스워드는 6자리 이상 입력하세요.');
			msg ="패스워드는 6자리 이상 입력해주세요";
			keyA = false;
		}else{
				keyA = true;
			}
	});

	$('#pw_check').on('change', function() {
		checkpwd = $('#pw_check').val();
		if(keyA)
			{
				if (oripwd != checkpwd) {
					alert('패스워드가 다릅니다.');
					msg = "패스워드가 다릅니다";
					keyB = false;
				}else{
					keyB = true;
				}
			}
		else{
				alert(msg);
			}

	});

	$('#reload_pw').on('click',function(){
		var pw = $('#re_pw').val();
		if(keyA && keyB)
			{
			$.ajax({
					url : "re_pw.whame",
					type : 'post',
					data : {
							'pw' : pw
						},
					success : function(result){
							if(result == 1)
								{
									$(location).attr('href','remember.whame');
								}
						}
				})
			}else if(!keyA && !keyB)
				{
					alert("정보를 확인하세요");
				}
			else if(!keyA && keyB)
			{
				alert("비밀번호 6자리 입력하세요.");
			}else if(keyA && !keyB)
			{
				alert("비밀번호가 다릅니다.");
			}
	});
	

});
</script>