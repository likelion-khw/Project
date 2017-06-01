<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="spring.mvc.whame.login.* , java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.enrollform{
	margin-top:20px;
}

.enrollform th{
	width:20%;
}

@media only screen and (min-width : 321px) and (max-width : 600px) {
	.enrollform{
	width:95%;
	}

	.enrollform th{
	width:0;
	}
	.enrollform td{
	width:100%;
	}
}
</style>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
<div class="container center-align enrollform">
<h4>${memberVO.userid}님<br> 상점을 등록하는 페이지입니다.</h4>
	<form action="enrollconnect.whame" method="post"  enctype="multipart/form-data" id="enroll_form">
	 <input type="hidden" name="userid" value="${memberVO.userid}"> 
	<table class="centered">
		<tr>
			<th>사업자등록번호</th>
			<td><input type="text" id="busi_code1" class="col s2" maxlength="3">
			<input disabled value="-" id="disabled" type="text" class="col s1">
			<input type="text" id="busi_code2" class="col s2" maxlength="2">
			<input disabled value="-" id="disabled" type="text" class="col s1">
			<input type="text" id="busi_code3" class="col s3" maxlength="5">
			<input type="hidden" name="business_code" id="business_code" value="">
			<input type="button" id="busi_check" value="조회" class="btn">
			</td>
		</tr>
		
		<tr>
			<th>지역코드</th>
			<td>
				<label>음식점 지역 카테고리</label>
				  <select class="browser-default" name="regionSelect" id="regionSelect" onchange="changeRegion()">
				    <option>지역 선택</option>
				    <option>서울특별시</option>
				    <option>부산</option>
				    <option>대구</option>
				    <option>대전</option>
				    <option>울산</option>
				    <option>인천</option>
				    <option>광주</option>
				    <option>제주</option>
				  </select>
				  <label>음식점 위치 카테고리</label>
				  <select class="browser-default" name="regionDetail" id="regionDetail">
				    <option >위치 선택</option>
				  </select>
			</td>
		</tr>
		<tr>
			<th>나머지주소</th>
			<td>
				<input type="text" name="regionAdd" id ="regionAdd" class="col s6">
				<input type="button" class="btn" id="searchrcode" value="조회">
			</td>
		</tr>

		<tr>
			<th>가게 상호명</th><td><input type="text" name="store_name"></td>
		</tr>
		
		<tr>
			<th>가게 분류</th>
			<td>
				<label>음식점 카테고리</label>
				<select class="browser-default" name="categorySelect" id="categorySelect" onchange="changeCategory()" >
					<option>음식점 카테고리 선택</option>
					<option>한식</option>
					<option>양식</option>
					<option>중식</option>
					<option>일식</option>
					<option>카페</option>
				</select>
			<br>				
				<label>메뉴 카테고리 선택</label>
				<select class="browser-default" name="categoryDetail" id="categoryDetail">
				<option>메뉴 선택</option>
				</select>
			</td>
		</tr>
		
		<tr>
			<th>영업시간</th><td><input type="text" name="operating_time"></td>
		</tr>
		<tr>
			<th>간판이미지</th><td><input type="file" name="imagefile"></td>
		
		<tr><td colspan="2"><input type="button" class="btn" value="등록하기" id="e_submit"></td></tr>
	</table>
	</form>
</div>
   
<script type="text/javascript" src="resources/js/enrollform_js.js"></script>
<script type="text/javascript" src="resources/js/busi_check.js"></script>
<script type="text/javascript">
$('#e_submit').on('click',function(){
		var chk1 = $('#business_code');
		var chk2 = $('#regionSelect');
		var chk3 = $('#regionDetail');
		var chk4 = $('#regionAdd')
		var chk5 = $('#categorySelect');
		var chk6 = $('#categoryDetail');
		var chk7 = $("#store_name");
		var chk8 = $('#operating_time');
		var chk9 = $('#imagefile');
		
		if(chk1.val() == ""){
			alert("사업자 번호를 인증하세요.");
		}else if(chk2.val() == ""){
			alert("지역을 선택해주세요");
		}else if(chk3.val() == ""){
			alert("구 선택해주세요");
		}else if(chk4.val() == ""){
			alert("나머지 주소를 입력하세요.");
		}else if(chk5.val() == ""){
			alert("음식점 종류를 입력하세요.");
		}else if(chk6.val() == ""){
			alert("음식점 메뉴를 입력하세요.");
		}else if(chk7.val() == ""){
			alert("상호명을 입력하세요.");
		}else if(chk8.val() == ""){
			alert("영업시간을 입력하세요");
		}else if(chk9.val() == ""){
			alert("간판 이미지를 올려주세요.");
		}else{
			$('form[id=enroll_form]').submit();
		}
	});
</script>