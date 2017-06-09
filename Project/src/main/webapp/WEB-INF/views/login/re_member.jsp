<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@	include file="../modal/remember_modal.jsp"%>
<%@include file="../modal/infomodal.jsp" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
<style>

.re_memberform1{
	margin-top:50px;
}

.re_memberform1 img{
	width: 200px;
	height: 200px;
}

.image {
    position:relative;
}
.image .text {
    position:absolute;
    top:70%; /* in conjunction with left property, decides the text position */
    left:43%;
    color:white;
}
@media only screen and (min-width : 321px) and (max-width : 500px) {
.image .text {
    position:absolute;
    top:65%; /* in conjunction with left property, decides the text position */
    left:41%;
    color:white;
    font-size: 10px;
}

.re_memberform1 th{
	width:1px;
}

.re_memberform1 img{
	width: 100px;
	height: 100px;
}
}

</style>
<div class="container">
	<div class="re_memberform1 center-align">
		<c:choose>
				<c:when test="${memberVO.userimage == ''}">
				<div class="image">
					<a href="">
						<img class="circle" src="resources/img/user.png" id="userimg">
					</a>
					<div class="text">
					    <p>이미지 변경하기</p>
					</div>
				</div>
				</c:when>
				<c:when test="${memberVO.userimage != ''}">
				<div class="image">
					<a href="">
						<img class="circle" src="${memberVO.userimage }" id="userimg">
					</a>
					<div class="text">
					    <p>이미지 변경하기</p>
					</div>
				</div>
				</c:when>
		</c:choose>
		<table class="centered">
			<tr>
				<th>닉네임</th>
				<td><input type="text" value="${memberVO.nickname }" class="col s6" disabled>
				<a href="#remember_nickname" class="btn">닉네임변경</a>
				</td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td><input type="password" value="${memberVO.pw }" class="col s6" disabled>
				<a href="#remember_pw" class="btn">패스워드변경</a>
				</td>
			</tr>
		</table>
	</div>
</div>