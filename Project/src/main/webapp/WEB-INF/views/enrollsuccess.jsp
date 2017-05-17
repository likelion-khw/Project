<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="spring.mvc.whame.login.*"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<% MemberVO membervo = (MemberVO)session.getAttribute("memberVO"); 
	int num =0;
%>

<body>
<%= membervo.getUserid() %>님 ${store_code}store의 메뉴를 업로드하세요. 
<form action="menuUpload.whame" method="post" id="menuform">
<input type="hidden" name="store_code" value="${store_code }">
<table border="1" id="menutable">
	
	<tr>
		<th>메뉴종류</th><th>메뉴명</th><th>가격</th><!-- <th><input type="button" value="추가" class="add"></th> -->
	</tr>
	<tr class="item">	
			<td>
			<select name="menu_type" id="menu_type">
			<c:forEach items="${typelist}" var="vo2" >
						<option>${vo2.type_name }</option>
			</c:forEach> 
			</select>
			</td>
			<td><input type="text" name="menu_name" id="menu_name"></td>
			<td><input type="text" name="menu_price" id= "menu_price"></td>
			<td><input type="button" value="등록" class="insBtn"></td>
			<!-- <td><input type="button" value="삭제" class="delBtn"></td> -->
	</tr>
	<tbody></tbody>

</table>
<div id="show"></div>
<input type="hidden" value="${menulist }" id ="menulist">
<input type="submit" value="메뉴등록">
</form>
 <script src="resources/jquery-3.1.1.min.js"></script>
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script> -->
<script type="text/javascript">
window.onload = function(){
var count=0;
var menulist = new Array();

/* 	$('.add').click(function(){
	 	 $('#menutable > tbody:last').append(
	 		 	 '<tr><td><select name="menu_type"><c:forEach items="${typelist}" var="vo2" >'
				+ ' <option value="${vo2.type_code }">${vo2.type_name }</option> ' 
				+ '	</c:forEach> </select></td> '
				+ ' <td><input type="text" name="menu_name"></td> '
				+ ' <td><input type="text" name="menu_price"></td> '
				+ ' <td><input type="button" value="완료" class="insBtn"></td>'
				+ ' <td><input type="button" value="삭제" class="delBtn"></td> '
				+ '	</tr>');  
	})  */
	
	$('.insBtn').click(function(){

		var menu = new Object();
		menu.menu_name= document.getElementById("menu_name").value;
		menu.menu_price= document.getElementById("menu_price").value;
		menu.menu_type= document.getElementById("menu_type").value;
		menu.store_code= ${store_code};
		menulist.push(menu);
		$('#menutable > tbody:last').append("<tr><td>"+ menu.store_code + "</td><td>"+menu.menu_name

+"</td><td>"+menu.menu_price+"</td><td>"+menu.menu_type+"</td></tr>");

		document.getElementById("menu_name").value = "";
		document.getElementById("menu_price").value = "";
		document.getElementById("menu_type").value =1;

		document.getElementById("show").innerHTML += "<input type=hidden name=menulist value=" + menu.menu_name + ":" 
														+ menu.menu_price + ":" + menu.menu_type + ">" ;
		

		}) 

/* 		$('#menuform').submit(function() { 
			alert(menulist.length);
			$("#show").innerHTML = "<input type='hidden' name='menulist' value="+ menulist +">"
			return true; 

		}); */
	
            /* // 항목추가 버튼 클릭시
            $(".add").live("click", function(){
                count++; 
                var clickedRow = $(this).parent().parent();
                var cls = clickedRow.attr("class");
 
                // tr 복사해서 마지막에 추가
                var newrow = clickedRow.clone();
                newrow.insertAfter($("#menutable ."+cls+":last"));
 
            }); */


            // 삭제버튼 클릭시
            $(".delBtn").live("click", function(){
                var clickedRow = $(this).parent().parent();
                var cls = clickedRow.attr("class"); 
                clickedRow.remove();
 
            }); 
}

</script>
</body>
</html>