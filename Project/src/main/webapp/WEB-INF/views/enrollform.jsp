<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="spring.mvc.whame.login.* , java.util.*"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<% MemberVO membervo = (MemberVO)session.getAttribute("memberVO"); %>
<%= membervo.getUserid() %>님의 상점을 등록하는 페이지입니다.
<form action="enrollconnect.whame" method="post"  enctype="multipart/form-data">
 <input type="hidden" name="userid" value="<%= membervo.getUserid() %>"> 
<table border="1">
	<tr>
		<th>사업자 등록번호 </th><td><input type="text" name="business_code"></td>
	</tr>
	
	<tr>
		<th>지역코드</th>
		<td>
			<select name="rcode1" id="rcode1" onchange="rcodeSelect()">
				<option >지역선택</option>
				<c:forEach items="${region }" var="vo">
					<option value="${vo.rname }">${vo.rname }</option>
				</c:forEach>
			</select>
			<select id="rcode2" name="rcode2">
				<option>선택하세요</option>
			</select>
		</td>
	</tr>
	<tr>
		<th>나머지주소</th>
		<td>
			<input type="text" name="detail" id ="detail">
			<input type="button" id="searchrcode" value="조회">
		</td>
	</tr>
	<tr>
		<th>가게 상호명</th><td><input type="text" name="store_name"></td>
	</tr>
	<tr>
		<th>영업시간</th><td><input type="text" name="operating_time"></td>
	</tr>
	<tr>
		<th>간판이미지</th><td><input type="file" name="imagefile"></td>
	
	<tr><td colspan="2"><input type="submit" value="등록하기"></td></tr>
</table>
</form>
   

<script src="resources/jquery-3.1.1.min.js"></script> 
<script type="text/javascript">

/* 
$(document).ready(function() { */
	function rcodeSelect(){

	    var gu = $("#rcode1").val();

	    var seoul = ["중구","종로구","서대문구", "마포구", "은평구", "동대문구",'중랑구','도봉구','성동구','강동구', '강남구','성북구','서초구','송파구','노원구','용산구','강북구','광진구','영등포구','관악구','구로구','금천구','동작구','강서구','양천구'];
		var busan = ['중구','동구','서구','사하구','영도구','동래구','남구','금정구','연제구','해운대구','수영구','부산진구','북구','사상구','강서구','기장군'];
		var daegu = ['중구','동구','북구','서구','달서구','남구','수성구','달성군'];
		var daejeon = ['동구','중구','서구','유성구','대덕구'];
		var incheon = ['중구','동구','남구','부평구','서구','남동구','연수구','계양구','응진군','강화군'];
		var gwangju = ['북구','동구','서구','남구','광산구'];
			 
	    var rcodelist;

	    if(gu == "서울"){
			rcodelist = seoul;
		}
	    else if(gu == "부산"){
		    rcodelist = busan;
		}
	    else if(gu == "대구"){
		    rcodelist = daegu;
		}
	    else if(gu == "대전"){
		    rcodelist = daejeon;
		}
	    else if(gu == "인천"){
		    rcodelist = incheon;
		}
	    else if(gu == "광주"){
		    rcodelist = gwangju;
		}

	    $('#rcode2').empty();

	    for(var count=0; count<rcodelist.length ; count++ ){
			var option = $("<option value="+rcodelist[count]+">" + rcodelist[count] + "</option>");
			$('#rcode2').append(option);
		}
	    
	}

/* 	$('#searchrcode').click(function(){
		var rcode1= document.getElementById("rcode1").value;
		var rcode2 = document.getElementById("rcode2").value;
		var detail = document.getElementById("detail").value;
		sendRedirect( "map.jsp?address="+rcode1+" "+rcode2+" "+detail); 
		
	}) */

</script>

</body>
</html>