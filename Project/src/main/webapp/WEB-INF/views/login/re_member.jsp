<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@	include file="../modal/remember_modal.jsp"%>
<%@include file="../modal/infomodal.jsp" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
<style>
.mb_remform{
	display: none;
}

.re_memberform1{
	margin-top:50px;
	height: 500px;
}

.re_memberform1 img{
	width: 200px;
	height: 200px;
}

.image {
    position:relative;
}
@media only screen and (min-width : 321px) and (max-width : 600px) {
	.re_memberform1 th{
		width:1px;
	}
	
	.re_memberform1 img{
		width: 100px;
		height: 100px;
	}

	.web_form{
		display:none;
	}
	.mb_remform{
		display: inherit;
	}
	
	.mb_remform th{
		width:500px;
		text-align: center;
		font-size:20px;
		background-color: #eceff1;
		border-style: groove;
	}
}


</style>
<div class="container">
	<div class="re_memberform1 center-align">
		<c:choose>
				<c:when test="${memberVO.userimage == ''}">
				<div class="image">
					<a href="javascript:;">
						<img class="circle" src="resources/img/user.png" id="re_img">
					</a>
					<div class="text">
					    <p>이미지 변경</p>
					</div>
				</div>
				</c:when>
				<c:when test="${memberVO.userimage != ''}">
				<div class="image">
					<a href="javascript:;">
						<img class="circle" src="${memberVO.userimage }" id="re_img">
					</a>
					<div class="text">
					    <p>이미지 변경</p>
					</div>
				</div>
				</c:when>
		</c:choose>
		<form action="re_img.whame" method="post" enctype="multipart/form-data" id="re_img_form">
			<input type="file" id="re_userimg" style="display:none" name="re_userimg">
		</form>
		<table class="centered">
			<tr class="mb_remform">
				<th>닉네임</th>
			</tr>
			<tr>
				<th class="web_form">닉네임</th>
				<td><input type="text" value="${memberVO.nickname }" class="col s6" disabled>
				<a href="#remember_nickname" class="btn">닉네임변경</a>
				</td>
			</tr>
			<tr class="mb_remform">
				<th>패스워드</th>
			</tr>
			<tr>
				<th class="web_form">패스워드</th>
				<td><input type="password" value="${memberVO.pw }" class="col s6" disabled>
				<a href="#remember_pw" class="btn">패스워드변경</a>
				</td>
			</tr>
		</table>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		$('#re_img').on('click',function(){
			$('#re_userimg').trigger('click');
		});

		$('#re_userimg').on('change', function() {
			if (this.files && this.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#re_img').attr('src', e.target.result);
				}
				reader.readAsDataURL(this.files[0]);
			}

			$('#re_img_form').submit();

		});
	})
</script>