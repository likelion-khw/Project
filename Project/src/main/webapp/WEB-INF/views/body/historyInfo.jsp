<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
${storevo.store_code }<br>
${storevo.business_code }<br>
${storevo.userid }<br>
${storevo.operating_time }<br>
${storevo.store_name }<br>
${storevo.view_count }<br><br> 

${locationvo.address }<br> 

<c:forEach items="${menulist}" var="vo" >
   ${vo.menu_type}:::${vo.menu_name}::::${vo.menu_price}<br>
</c:forEach> 
</body>
</html>