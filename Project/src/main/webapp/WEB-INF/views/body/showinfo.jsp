<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
td{
	border:1px gray solid;
}
</style>
<div class="container center-align">
	<h1>${error}</h1>
	<%if (request.getAttribute("error") == null){ %>
	<table class="centered bordered">
		<tr>
			<td>ocr</td>
			<td><c:forEach items="${result }" var="vo">
				${vo.text } <br>
				</c:forEach></td>
		</tr>
		<tr>
			<td>color:</td>
			<td>R: ${color.red }<br> G: ${color.green }<br> B:
				${color.blue }<br> CODE: ${color.store_code }
			</td>
		</tr>
		<tr>
			<td>menu</td>
			<td><c:forEach items="${menuList}" var="vo">
				${vo.menu_type} : ${vo.menu_name }  : ${vo.menu_price }<br>
				</c:forEach></td>
		</tr>
	</table>
	<%} %>
</div>
