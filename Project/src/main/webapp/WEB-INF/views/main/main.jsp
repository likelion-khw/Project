<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="spring.mvc.whame.login.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	MemberVO membervo = null;
	if ((MemberVO) session.getAttribute("memberVO") != null) {
		membervo = (MemberVO) session.getAttribute("memberVO");
		if (membervo.getUserid() == null) {
			response.sendRedirect("start.whame");
		}
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script src="resources/jquery-3.1.1.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<%=membervo.getUserid()%>�� ȯ���մϴ�.
	<table border="1">
		<tr>
			<td><a href="fileupload.whame">�޴�ã��(�����̹��� ���ε�)</a></td>
			<td><a href="enroll.whame">���ǵ���ϱ�</a></td>
			<td><a href="history.whame">�����丮</a></td>
			<td><a href="kakao.whame">īī�������� ��ġ����</a></td>
	</table>

	<input type="button" value="�α׾ƿ�" id="logout">

</body>

<script type="text/javascript">
	$(document).ready(function() {

		$('#logout').on('click', function() {
			localStorage.removeItem('userid'); //���� ���嵥���� ����
			$(location).attr('href', 'logout.whame');
		});
	})
</script>
</html>