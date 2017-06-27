<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<style>
@media only screen and (min-width : 321px) and (max-width : 500px) {
.remember_modalform{
	width:95%;
}
.modal-content{
	width:95%;
}
}
</style>

<!-- 닉네임 변경 모달 -->
<div id="qna" class="modal remember_modalform center-align">
	<div class="modal-content">
   <table>
   <tr>
   <dir><h3>문의하기</h3></dir>
   </tr>
     <tr>
      <td>&nbsp;</td>
      <td align="center">제목</td>
      <td><input name="title" id="title" size="50" maxlength="100"></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    <tr>
      <td>&nbsp;</td>
      <td align="center">이름</td>
      <td><input name="name" id="name" size="50" maxlength="50"></td>
      <td>&nbsp;</td>
     </tr>
      <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    <tr>
      <td>&nbsp;</td>
      <td align="center">비밀번호</td>
      <td><input type="password" id="pw1" name="password" size="50" maxlength="50"></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr>
     <tr>
      <td>&nbsp;</td>
      <td align="center">메일주소</td>
      <td><input type="text" id="email" name="email" size="50" maxlength="50"></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr>
      <td>&nbsp;</td>
      <td align="center">내용</td>
      <td><textarea style="width: 90%;height: 30%" name="memo" id="memo" cols="10" rows="20"></textarea></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr height="1" bgcolor="#82B5DF"><td colspan="4"></td></tr>
     <tr align="center">
      <td>&nbsp;</td>
      <td>&nbsp;</td>
     </tr>
    </table>
</div>
	<div class="modal-footer">
		<a href="#!"
			class="modal-action btn" id="send" style="float:none;">보내기</a>
		<a href="#!"
			class="modal-action modal-close btn" style="float:none;">취소</a>
	</div>
</div>

<script type="text/javascript">

	$('#send').on('click',function(){
		var a = $('#title').val();
		var b = $('#name').val();
		var c = $('#pw1').val();
		var d = $('#memo').val();
		var e = $('#email').val();
		console.log(c);
		if(a == ""){
			alert("내용을 확인해주세요.");
			$(location).attr('href', '#!');
		}else if(b == ""){
			alert("이름을 확인해주세요.");
			$(location).attr('href', '#!');
		}else if(c == ""){
			alert("비밀번호를 설정해주세요");
			$(location).attr('href', '#!');
		}else if(d == ""){
			alert("내용을 입력하세요.");
			$(location).attr('href', '#!');
		}else if(e ==""){
			alert("이메일을 입력해주세요.");
			$(location).attr('href', '#!');
		}else{
			 $.ajax({   
				   type: "GET"  
				  ,url: "email.whame"
				  ,data: {title:a,name:b,pw:c,memo:d,email:e}
				  ,success:function(data){
					alert("전송되었습니다.")
					$(location).attr('href', 'qna.whame');
				  }
				  ,error:function(data){
				    alert("전송이 실패하였습니다. 다시 확인해 주세요.");
				  }
				  });
		}
	});
</script>