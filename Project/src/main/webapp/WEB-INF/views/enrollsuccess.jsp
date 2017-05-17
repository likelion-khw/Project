<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="spring.mvc.whame.login.*"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=tyQWZBNLl1rXODDbpl06&submodules=geocoder"></script>
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
<div id="map" style="width:100%;height:400px;"></div>
	<div id="wrap" class="section">
	    <div id="map" style="width:100%;height:600px;">
	        <div class="search" style=""></div>
	    </div>
	    <code id="snippet" class="snippet"></code>
	</div>
 <script src="resources/jquery-3.1.1.min.js"></script>
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script> -->
<script type="text/javascript">
/* window.onload = function(){ */
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
           /*  $(".delBtn").live("click", function(){
                var clickedRow = $(this).parent().parent();
                var cls = clickedRow.attr("class"); 
                clickedRow.remove();
 
            });  */

            
	var map = new naver.maps.Map('map');
    var myaddress = "${address}";
    alert(myaddress);
   // var myaddress = "역삼동 745";/* 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!) */
    naver.maps.Service.geocode({address: myaddress}, function(status, response) {
        if (status !== naver.maps.Service.Status.OK) {
            return alert(myaddress + '의 검색 결과가 없거나 기타 네트워크 에러');
        }
        var result = response.result;
        // 검색 결과 갯수: result.total
        // 첫번째 결과 결과 주소: result.items[0].address
       alert(result.items[0].point.y+":"+ result.items[0].point.x);
       document.getElementById("show").innerHTML += "<input type=hidden name='latitude' value=" + result.items[0].point.y +">"
       												+ "<input type=hidden name='longitude' value=" + result.items[0].point.x +">";
       												
        var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
        map.setCenter(myaddr); // 검색된 좌표로 지도 이동
        // 마커 표시
        var marker = new naver.maps.Marker({
          position: myaddr,
          map: map
        });
        // 마커 클릭 이벤트 처리
        naver.maps.Event.addListener(marker, "click", function(e) {
          if (infowindow.getMap()) {
              infowindow.close();
          } else {
              infowindow.open(map, marker);
          }
        });
        // 마크 클릭시 인포윈도우 오픈
        var infowindow = new naver.maps.InfoWindow({
            content: '<h4> [WHAME]</h4><a href="" target="_blank"><img src=""></a>'
        });
    });
//}

</script>
</body>
</html>