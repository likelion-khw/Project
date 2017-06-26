<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="spring.mvc.whame.login.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../modal/infomodal.jsp" %>
<%
	MemberVO membervo = (MemberVO) session.getAttribute("memberVO");
	int num = 0;
%>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=29f76818662c66dfd2d4ad5567254a3e&libraries=services"></script>
<style>
.menu_view{
	margin-top:20px;
	margin-bottom:20px;
}
</style>
<script type="text/javascript">
var modalopen = function(){
	$('#enroll_menu_select').modal('open');
}
</script>
<body onload="modalopen();">
<div class="container center-align">
	<div class="menu_view">
	<h4><%=membervo.getNickname()%>님 ${store_name}의 초기 메뉴를 업로드하세요.
	</h4>
	<h5>추후에도 변경 및 추가 하실 수 있습니다.</h5>
		<form action="menuUpload.whame" method="post" id="menuform">
			<input type="hidden" name="store_code" value="${store_code }">
			<input type="hidden" name="address" value="${address}">
			<input type="hidden" name="lat" id="lat">
			<input type="hidden" name="lon" id="lon">
			<table id="menutable" class="centered">
				<thead>
				<tr>
					<th>메뉴종류</th>
					<th>메뉴명</th>
					<th>가격</th>
					<!-- <th><input type="button" value="추가" class="add"></th> -->
				</tr>
				</thead>
				<tbody id="menu_t">
				</tbody>
			</table>
			<div id="show"></div>
		<table class="centered">
			<tr class="item">
					<td><select name="menu_type" id="menu_type"
						class="browser-default">
							<c:forEach items="${typelist}" var="vo2">
								<option>${vo2.type_name}</option>
							</c:forEach>
					</select></td>
					<td><input type="text" id="menu_name"></td>
					<td><input type="text" id="menu_price"></td>
					<td><input type="button" value="등록" class="insBtn btn"></td>
					<!-- <td><input type="button" value="삭제" class="delBtn"></td> -->
				</tr>
		</table>
		<input type="hidden" value="${menulist }" id="menulist"> <input
				type="submit" value="메뉴등록" class="btn">
		</form>
	</div>
	<div id="map" style="width: 100%; height: 350px;"></div>
</div>
</body>

<script type="text/javascript">
	/* window.onload = function(){ */
	$('.insBtn')
			.click(
					function() {
						var menu = new Object(); $('#menu_name').val();
						menu.menu_name = $('#menu_name').val();
						menu.menu_price = $('#menu_price').val();
						menu.menu_type = $('#menu_type').val();
						$('#menu_t').append(
								"<tr><td>"
										+ menu.menu_type + "</td><td>"
										+ menu.menu_name + "</td><td>"
										+ menu.menu_price + "</td></tr>");
						$('#menu_name').val("");
						$('#menu_price').val("");
						$('#show').html($('#show').html() + "<input type=hidden name=menulist value=" + menu.menu_name + ":" 
								+ menu.menu_price + ":" + menu.menu_type + ">");

					})

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center : new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		level : 3
	// 지도의 확대 레벨
	};
	// 지도를 생성합니다    
	var map = new daum.maps.Map(mapContainer, mapOption);
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new daum.maps.services.Geocoder();
	// 주소로 좌표를 검색합니다
	geocoder
			.addr2coord(
					'${address}',
					function(status, result) {
						// 정상적으로 검색이 완료됐으면 
						if (status === daum.maps.services.Status.OK) {
							var lat = (result.addr[0].lat).toFixed(6);
							var lon = (result.addr[0].lng).toFixed(6);
							var coords = new daum.maps.LatLng(
									result.addr[0].lat, result.addr[0].lng);
							// 결과값으로 받은 위치를 마커로 표시합니다
							var marker = new daum.maps.Marker({
								map : map,
								position : coords
							});
							// 인포윈도우로 장소에 대한 설명을 표시합니다
							var infowindow = new daum.maps.InfoWindow(
									{
										content : '<div style="width:150px;text-align:center;padding:6px 0;">${store_name}</div>'
									});
							infowindow.open(map, marker);
							// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
							map.setCenter(coords);
							$('#lat').val(lat);
							$('#lon').val(lon);
						}
					});
	//}
		
		$('#enroll_menu_no').on('click',function(){
			$('#menuform').submit();
		});
	
</script>
