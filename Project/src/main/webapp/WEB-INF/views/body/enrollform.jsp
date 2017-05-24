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
<div class="container center-align enrollform">
<h4>${memberVO.nickname}님<br> 상점을 등록하는 페이지입니다.</h4>
	<form action="enrollconnect.whame" method="post"  enctype="multipart/form-data" id="enroll_submit">
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
				<label>시분류</label>
				  <select class="browser-default" name="rcode1" id="rcode1" onchange="rcodeSelect()">
				    <option >지역선택</option>
					<c:forEach items="${region}" var="vo">
						<option value="${vo.rname }">${vo.rname}</option>
					</c:forEach>
				  </select>
				  
				  <label>구분류</label>
				  <select class="browser-default" name="rcode2" id="rcode2">
				    <option >구 선택</option>
				  </select>
			</td>
		</tr>
		<tr>
			<th>나머지주소</th>
			<td>
				<input type="text" name="detail" id ="detail" class="col s6">
				<input type="button" class="btn" id="searchrcode" value="조회">
			</td>
		</tr>
		<tr>
			<th>가게 상호명</th><td><input type="text" name="store_name"></td>
		</tr>
		<tr>
			<th>영업시간</th><td><input type="text" name="operating_time"></td>
		</tr>
		<tr>
			<th>간판이미지</th><td><input type="file" name="imagefile"></td>
		
		<tr><td colspan="2"><input type="button" class="btn" value="등록하기" id="submit"></td></tr>
	</table>
	</form>
</div>
   
<script type="text/javascript" src="resources/js/enrollform_js.js"></script>
<script type="text/javascript" src="resources/js/busi_check.js"></script>
</body>
</html>