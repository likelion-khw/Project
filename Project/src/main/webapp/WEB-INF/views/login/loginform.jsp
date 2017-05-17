<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link
	href="https://fonts.googleapis.com/css?family=Amaranth|Bad+Script|Farsan"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.1/css/materialize.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.1/js/materialize.min.js"></script>
<script src="resources/jquery-3.1.1.min.js"></script>

<title>로그인 폼</title>
<style>
body {
	text-align: center;
}

h1 {
	font-family: 'Bad Script', cursive;
}

h3 {
	font-family: 'Barrio', cursive;
}

table {
	width: 400px;
	margin: auto;
	margin-top: 100px;
	text-align: center;
	background-color: rgba(255, 255, 255, 0.5);
	font-family: 'Farsan', cursive;
}

th, td {
	font-size: 20px;
	text-align: center;
}

td {
	font-size: 20px
}
</style>
</head>

<body style="background-color:;">

	<table class="centered">
		<tr>
			<td colspan="2"><h1
					class="card-panel #546e7a blue-grey darken-3">Login Form</h1></td>
		</tr>
		<tr>
			<th>ID :</th>
			<td><input type="text" name="userid" value="" id="userid"></td>
		</tr>
		<tr>
			<th>PASSWORD</th>
			<td><input type="password" name="pw" id="pw"></td>
		</tr>
		<tr>
			<td colspan="2"><input type="button" value="login"
				class="waves-effect waves-teal btn-flat" id="login"></td>
		</tr>
	</table>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$('#login').on('click', function() {
			var userid = $('#userid').val();
			var pw = $('#pw').val();
			var msg;

			if (userid == "" || pw == "") {
				if(userid == "")
					{
						msg = "아이디를 입력하세요.";
					}
				else
					{
						msg = "패스워드를 입력하세요";
					}
				alert(msg);
			} else {
				$.ajax({
					url : 'start.whame',
					type : 'post',
					data : {
						'userid' : userid,
						'pw' : pw,
					},
					success : function(result) {
						if (result == 0) {
							alert("해당 아이디는 없습니다.")
							$('#userid').val("");
							$('#pw').val("");
						} else if (result == 1) {
							alert("패스워드가 다릅니다.")
							$('#userid').val(userid);
							$('#pw').val("");
						} else if (result == 2) {
							$(location).attr('href','index.whame');
						}
					}
				});
			}
		});
	})
</script>

</html>
