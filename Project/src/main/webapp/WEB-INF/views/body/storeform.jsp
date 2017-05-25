<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="spring.mvc.whame.store.*,java.util.*"%>
<%@include file="../modal/menu_modal.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
<style>
.storeform{
	margin-top:5%;
	padding-top: 20px;
	padding-bottom: 20px;
	width: 90%;
}

.storeform .empt{
	margin-top:30%;
}

.storeform .collapsible-body{
	padding-top:5%;
	padding-bottom:5%;
}
</style>
<div class="container storeform center-align">
	<c:choose>
		<c:when test="${storelist != null}">
			<ul class="collapsible" data-collapsible="accordion">
				<c:forEach items="${storelist}" var="store">
				<li>
			      <div class="collapsible-header"><i class="material-icons">filter_drama</i><h5>${store.store_name}</h5></div>
			      <div class="collapsible-body">
			      	<div class="container" id="${store.store_code}">
				      	<table class="centered">
				      		<tr>
					      		<th>상점코드</th>
					      		<td>${store.store_code }</td>
				      		</tr>
				      		<tr>
					      		<th>사업자번호</th>
					      		<td>${store.business_code }</td>
				      		</tr>
				      		<tr>
					      		<th>영업시간</th>
					      		<td>${store.operating_time }</td>
				      		</tr>
				      		<tr>
					      		<th>캡쳐 횟수</th>
					      		<td>${store.view_count}</td>
				      		</tr>
				      	</table>
				      	<input type="button" value="메뉴정보" class="btn">
			      	</div>
			      </div>
			    </li>
				</c:forEach>
			  </ul>
		</c:when>
		<c:otherwise>
			<div class="empt">
				<h3>등록된 상가 정보가 없습니다.</h3>
				<h5>상가를 등록하시겠습니까?</h5>
				<input type="button" class="btn" value="간판등록하기" id="enroll"><br>
			</div>
		</c:otherwise>
	</c:choose>
</div>

<script type="text/javascript">
$(document).ready(function() {
	$("#fileupload").on('click',function(){
		$('#modal1').modal('open');
	});

	$("#enroll").on('click',function(){
		$(location).attr('href','enroll.whame');
	});

	$('input[value=메뉴정보]').on('click',function(){
		var store_code = $(this).parent().attr('id');
		$('#'+store_code+"modal").modal('open');
	});
})
</script>