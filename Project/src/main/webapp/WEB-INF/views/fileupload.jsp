<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="spring.mvc.whame.login.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<% MemberVO membervo = (MemberVO)session.getAttribute("memberVO"); %>
<%= membervo.getUserid() %>님 간판이미지를 업로드하세요.
<!-- showinfo.whame -->
<form action="image.whame" method="post" enctype="multipart/form-data">
	이미지파일 : <input type="file" name="imagefile"><br>
	<input type="submit" value="전송하기">
	<div id="lal"></div>
</form>
<div id="div2"></div>
<script src="resources/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
function success(position){
	var lat = (position.coords.latitude).toFixed(6);
	var lon = (position.coords.longitude).toFixed(6);
	document.getElementById("lal").innerHTML += "<input type=hidden name=lat value=" + lat + ">"
						+"<input type=hidden name=lon value=" + lon + ">";
}

function error(err){
	$('div').text("조회 실패 ==>" + err.code);
}


$(document).ready(function(){
	//위치추적:네트워크 연결되어있어야함!
	window.onload = location();
	function location(){
		window.navigator.geolocation.getCurrentPosition(success, error);//()를 붙여 자동호출하는것 x
	}
		
})

</script>
</body>
</html>