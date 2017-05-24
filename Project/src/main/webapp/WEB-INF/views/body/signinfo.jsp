<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
${error }
<table border="1">
	<tr>
		<td>ocr</td>
		<td>
			<c:forEach items="${result }" var="vo">
				${vo.text } <br>
			</c:forEach>
		</td>	
	</tr>
	<tr>
		<td>color: </td>
		<td>R: ${color.red }<br>
			G: ${color.green }<br>
			B: ${color.blue }<br>
			CODE: ${color.store_code }
		</td>
	</tr>
	<tr>
		<td>menu</td>
		<td>
			<c:forEach items="${menuList }" var="vo">
				${vo.menu_type} : ${vo.menu_name }  : ${vo.menu_price }<br>
			</c:forEach>
		</td>	
	</tr>
</table>
</body>
</html>