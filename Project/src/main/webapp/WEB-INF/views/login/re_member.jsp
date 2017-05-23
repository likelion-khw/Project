<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.re_memberform{
	margin-top:50px;
	
}
</style>
<div class="container">
	<div class="re_memberform center-align">
		<c:choose>
			<c:when test="${memberVO.userimage == ''}">
				<img class="circle" src="resources/img/user.png" style="width: 30%; height:30%" id="userimg">
			</c:when>
			<c:when test="${memberVO.userimage != ''}">
				<img class="circle" src="${memberVO.userimage }" style="width: 30%; height:30%" id="userimg">
			</c:when>
		</c:choose>
		<table class="centered">
			<tr>
				<td>사용자 아이디</td>
				<td><input type="text" value="${memberVO.userid }"></td>
			</tr>
			<tr>
				<td>패스워드</td>
				<td><input type="text" value="${memberVO.pw }"></td>
			</tr>
		</table>
	</div>
</div>