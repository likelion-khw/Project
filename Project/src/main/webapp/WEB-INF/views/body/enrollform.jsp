<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="spring.mvc.whame.login.* , java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.enrollform{
	margin-top:20px;
	padding:20px;
	width: 85%;
}

.enrollform th{
	width:20%;
}

.mb_enform{
	display: none;
}
.row .col.s3{
	width: 20%;
}
@media only screen and (min-width : 321px) and (max-width : 600px) {
	.enrollform{
	width:90%;
	}

	.enrollform td{
	width:100%;
	}
	.web_form{
		display:none;
	}
	.mb_enform{
		display: inherit;
	}
	
	.mb_enform th{
		width:600px;
		text-align: center;
		font-size:20px;
		background-color: #eceff1;
		border-radius:40px;
	}
}
</style>
<!-- jQuery와 Postcodify를 로딩한다 -->
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
<div class="container center-align enrollform z-depth-3">
<h4>${memberVO.nickname} 님<br> 상점을 등록 페이지</h4>
	<form action="enrollconnect.whame" method="post"  enctype="multipart/form-data" id="enroll_form">
	 <input type="hidden" name="userid" value="${memberVO.userid}"> 
	<table class="centered">
		<tr class="mb_enform">
			<th>사업자등록번호</th>
		</tr>
		<tr>
			<th class="web_form">사업자등록번호</th>
			<td><input type="text" id="busi_code1" class="col s2" maxlength="3" placeholder="***">
			<input disabled value="-" id="disabled" type="text" class="col s1">
			<input type="text" id="busi_code2" class="col s2" maxlength="2" placeholder="**">
			<input disabled value="-" id="disabled" type="text" class="col s1">
			<input type="text" id="busi_code3" class="col s3" maxlength="5" placeholder="*****">
			<input type="hidden" name="business_code" id="business_code" value="">
			<input type="button" id="busi_check" value="조회" class="btn blue">
			</td>
		</tr>
		<tr class="mb_enform">
			<th>상가주소</th>
		</tr>
		<tr>
			<th class="web_form">상가주소</th>
			<td id="postcodify_search_button">
				<input type="button" value="검색" class="btn blue">
				<input type="text" class="postcodify_extra_info col s6" value="" placeholder="동" name="en_dong"/>
				<input type="text" name="en_address" id="en_address" class="postcodify_address col s12" value="" placeholder="시/군/구"/>
			</td>
		</tr>
		<tr class="mb_enform">
			<th>가게 분류</th>
		</tr>
		<tr>
 			<th class="web_form">가게 분류</th>
 			<td>
 				<label>음식점 카테고리</label>
 				<select class="browser-default" name="categorySelect" id="categorySelect" onchange="changeCategory()" >
 					<option disabled="disabled" selected="selected">음식점 카테고리 선택</option>
 					<option>한식</option>
 					<option>중식</option>
 					<option>일식</option>
 					<option>양식</option>
 					<option>패스트푸드</option>
 					<option>디저트</option>
 				</select>
 				<br>				
 				<label>메뉴 카테고리 선택</label>
 				<select class="browser-default" name="store_category" id="store_category">
 					<option>메뉴 선택</option>
 				</select>
 			</td>
 		</tr>
		<tr class="mb_enform">
			<th>가게 상호명</th>
		</tr>
		<tr>
			<th class="web_form">가게 상호명</th><td><input type="text" name="store_name" placeholder="상호명 입력"></td>
		</tr>
		<tr class="mb_enform">
			<th>영업시간</th>
		</tr>
		<tr>
			<th class="web_form">영업시간</th><td><input type="text" name="operating_time" placeholder="영업시간 입력"></td>
		</tr>
		<tr class="mb_enform">
			<th>간판이미지</th>
		</tr>
		<tr>
			<th class="web_form">간판이미지</th><td><input type="file" name="imagefile"></td>
		
		<tr><td colspan="2"><input type="button" class="btn green" value="등록하기" id="e_submit"></td></tr>
	</table>
	</form>
</div>
   
<script type="text/javascript" src="resources/js/busi_check2.js"></script>
<script type="text/javascript" src="resources/js/enrollform_js.js"></script>
<script type="text/javascript">
$(function() { $("#postcodify_search_button").postcodifyPopUp(); }); 

$('#e_submit').on('click',function(){
		var a = $('#business_code');
		var b = $('#en_address');
		var c = $('#categorySelect');
		var d = $('#categoryDetail');
		var e = $("#store_name");
		var f = $('#operating_time');
		var g = $('#imagefile');
		
		if(a.val() == ""){
			alert("사업자 번호를 인증하세요.");
		}else if(b.val() == ""){
			alert("주소를 입력해주세요.");
		}else if(c.val() == ""){
			alert("음식점 카테고리를 선택하세요.");
		}else if(d.val() == ""){
			alert("메뉴 카테고리를 선택하세요.");
		}else if(e.val() == ""){
			alert("상호명을 입력하세요.");
		}else if(f.val() == ""){
			alert("영업시간을 입력하세요");
		}else if(g.val() == ""){
			alert("간판 이미지를 올려주세요.");
		}else{
			$('form[id=enroll_form]').submit();
		}
	});
</script>
