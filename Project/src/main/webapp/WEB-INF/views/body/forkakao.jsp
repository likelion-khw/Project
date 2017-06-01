<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../modal/fileupload_modal.jsp" %>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=bf657f021b380e68b1a07c1e4fd92c88&libraries=services"></script>
<style>
.showinfoform{
	margin-top:20px;
	width:80%;
	padding:20px;
}
.showinfo_card{
	width:60%;
	float: left;
}
.showinfo_menu{
	width:100%;
	margin-left:auto;
	margin-right: auto;
}
.showinfo_btn{
	padding-top:15%;
	height: 350px;
}
.hidemenu{
	display: none;
}

@media only screen and (min-width : 300px) and (max-width : 600px) {

	.showinfoform{
	width:90%;
	padding:20px;
	}
	.showinfo_card{
		width:60%;
		float: left;
	}
	.showinfo_menu{
		width:100%;
		margin-left:auto;
		margin-right: auto;
	}
	.showinfo_btn{
	padding-top:40%;
	height: 360px;
}
}
</style>
<div class="container center-align z-depth-3 showinfoform">
			<h4>${store.store_name}의 메뉴정보</h4>
			<label>메뉴종류</label>
			 	<center>
					<select class="browser-default" id="menu_type" style="width:40%">
					<c:forEach items="${menutype}" var="type">
		   					<option value="${type}">${type}</option>
					</c:forEach>
		 			</select>
				</center>
			<div class="showinfo_menu">
				<table class="centered bordered highlight">
					<thead>
						<tr>
							<th>메뉴 종류
							</th>
							<th>메뉴 이름
							</th>
							<th>가격
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${menuList}" var="menu">
						<tr class="menu_list hidemenu" id="${menu.menu_type}">
							<td>${menu.menu_type}</td>
							<td>${menu.menu_name}</td>
							<td>${menu.menu_price}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="showinfo_card center-align">
				<div class="card">
				    <div class="card-image waves-effect waves-block waves-light">
				      <div id="map" style="width: 100%; height: 250px;"></div>
				    </div>
				    <div class="card-content">
				      <span class="card-title activator grey-text text-darken-4">${store.store_name}<i class="material-icons right">more_vert</i></span>
				    </div>
				    <div class="card-reveal">
				      <span class="card-title grey-text text-darken-4">${store.store_name}<i class="material-icons right">close</i></span>
				      	<div style="margin-top:30px;">
					      	<table class="centered">
					      		<tr>
					      			<td>영업시간</td>
					      			<td>${store.operating_time}</td>
					      		</tr>
					      		<tr>
					      			<td>사업자등록번호</td>
					      			<td>${store.business_code}</td>
					      		</tr>
					      		<tr>
					      			<td>주 소</td>
					      			<td>${location.address}</td>
					      		</tr>
					      	</table>
				      	</div>
				    </div>
				  </div>
			</div>
			<div class="showinfo_btn center-align">
				<input type="button" value="다른검색" class="btn green" id="re_search"><br><br>
				<input type="button" value="메인이동" class="btn red" id="main_load"><br><br>
			</div>
</div>

<script type="text/javascript">
$(document).ready(function() {
		var address = '${location.address}';

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			draggable:false,
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
				address,
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
									content : '<div style="width:150px;text-align:center;padding:6px 0;">${store.store_name}</div>'
								});
						infowindow.open(map, marker);
						// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
						map.setCenter(coords);
					}
				});

		$("#re_search").on('click',function(){
			$('#modal1').modal('open');
		});

		$("#history_load").on('click',function(){
			$(location).attr('href','history.whame');
		});

		$("#main_load").on('click',function(){
			$(location).attr('href','/whame');
		});

		var selecttype;
		$('#menu_type:first-child').attr('selected');
		selecttype = $('#menu_type').val();
		$('tr#'+selecttype).removeClass('hidemenu');

		$('#menu_type').on('change',function(){
			selecttype = $(this).val();
			$('tr[class=menu_list]').addClass('hidemenu');
			var check = /[&]/gi;
			if(check.test(selecttype) == true){
				$('tr#커피\\&라떼').removeClass('hidemenu');
			}else{
			$('tr#'+selecttype).removeClass('hidemenu');
			}
		})
})
</script>
