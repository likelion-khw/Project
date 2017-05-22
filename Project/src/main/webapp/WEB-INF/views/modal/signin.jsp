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
		이미지 변경하기<br>
		<a href="javascript:;" id="img">
		<img class="circle"
						src="resources/img/user.png" style="width: 30%; height:30%" id="userimg"></a>
		<div class="row">
		      <div class="row">
		        <div class="input-field col s12">
		          <i class="material-icons prefix">account_circle</i>
		          <input id="userid" type="email" class="validate" name="userid">
         		  <label for="email" data-error="이메일형식!" data-success="확인완료">사용자 아이디</label>
		        </div>
		        <div class="input-field col s12">
		          <i class="material-icons prefix">https</i>
		          <input id="pw" type="password" class="validate" name="pw">
		          <label for="pw" id="passwordl">패스워드</label>
		        </div>
		        <div class="input-field col s12">
		          <i class="material-icons prefix">lock_outline</i>
		          <input id="pwcheck" type="password" class="validate">
		          <label for="pwcheck" id="pwdl">패스워드확인</label>
		        </div>
		      </div>
		  </div>
		<input type="file" name="image" id="image" style="display: none;">
		</form>
	</div>

	<div class="modal-footer">
		<a href="#!"
			class="modal-action modal-close btn">취소</a>
		<a href="#!" class="modal-action modal-close btn" id="success">확인</a> 
	</div>
</div>

<script type="text/javascript">
      $(document).ready(function() {
          var oripw;
          var checkpw;
          
          $('#pw').on('change',function(){
			oripwd = $('#pw').val();
			if(oripwd.length < 6)
				{
					alert('패스워드는 6자리 이상 입력하세요.');
				}	
          });

          $('#pwcheck').on('change',function(){
  			checkpwd = $('#pwcheck').val();

  			if(oripwd != checkpwd)
  	  			{
					alert('패스워드가 다릅니다.');
  	  			}
	  			
            });

          $('#img').on('click',function(){
				$('#image').trigger('click');
            });

          $('#image').on('change',function(){
        	  if (this.files && this.files[0]) {
                  var reader = new FileReader(); 
                  reader.onload = function (e) { 
                      $('#userimg').attr('src', e.target.result);
                  }                    
                  reader.readAsDataURL(this.files[0]);
              }
        		
            });

          $('#success').on('click',function(){
				$('#signnew').submit();
             });
      });
</script>