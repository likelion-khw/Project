<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container center-align">
<c:forEach items="${historylist}" var="vo" >
	<img src="http://s3-ap-northeast-1.amazonaws.com/whame01/StoreTitle/${vo.signimage }" alt="경로오류"><br>
		${vo.store_code }<br>
</c:forEach> 
</div>
