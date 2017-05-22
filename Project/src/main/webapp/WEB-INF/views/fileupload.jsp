<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="spring.mvc.whame.login.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	MemberVO membervo = (MemberVO) session.getAttribute("memberVO");
%>
<%=membervo.getUserid()%>님 간판이미지를 업로드하세요.
<!-- showinfo.whame -->
<form action="image.whame" method="post" enctype="multipart/form-data">
	이미지파일 : <input type="file" name="imagefile"><br> <input
		type="submit" value="전송하기">
</form>

