<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="spring.mvc.whame.login.*"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% MemberVO membervo = (MemberVO)session.getAttribute("memberVO"); 
	int num =0;
%>

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
<div id="map" style="width:100%;height:350px;"></div>
	
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=37398369e1a52d60bd562e99b1d140aa&libraries=services"></script>
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
            
            var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
            mapOption = {
                center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };  
        // 지도를 생성합니다    
        var map = new daum.maps.Map(mapContainer, mapOption); 
        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new daum.maps.services.Geocoder();
        // 주소로 좌표를 검색합니다
        geocoder.addr2coord('${address}', function(status, result) {
            // 정상적으로 검색이 완료됐으면 
             if (status === daum.maps.services.Status.OK) {
				var lat = (result.addr[0].lat).toFixed(6);
				var lon = (result.addr[0].lng).toFixed(6);
                var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);
        		alert(result.addr[0].lat+","+ result.addr[0].lng);
        		document.getElementById("show").innerHTML += "<input type=hidden name='lat' value=" + lat +">"
															+ "<input type=hidden name='lon' value=" + lon +">"
															+ "<input type=hidden name='address' value='${address}'>";
                // 결과값으로 받은 위치를 마커로 표시합니다
                var marker = new daum.maps.Marker({
                    map: map,
                    position: coords
                });
                // 인포윈도우로 장소에 대한 설명을 표시합니다
                var infowindow = new daum.maps.InfoWindow({
                    content: '<div style="width:150px;text-align:center;padding:6px 0;">${store_name}</div>'
                });
                infowindow.open(map, marker);
                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                map.setCenter(coords);
            } 
        });    
//}
</script>
