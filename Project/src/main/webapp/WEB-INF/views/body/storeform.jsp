<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="spring.mvc.whame.store.*,java.util.*"%>
<%@include file="../modal/menu_modal.jsp" %>
<%@include file="../modal/store_modal.jsp" %>
<%@include file="../modal/coupon_modal.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=
f0f441314c4cc2b255e1663dc273009f&libraries=services"></script>
<style>
.storeform{
	margin-top:5%;
	padding-top: 20px;
	padding-bottom: 20px;
	width: 90%;
}

.storeform .empt{
	margin-top:20%;
}

.storeform .collapsible-body{
	padding-top:5%;
	padding-bottom:5%;
}

.maps{
	width:60%; 
	height:250px; 
	margin-bottom:20px;
}
.hidemenu{
	display: none;
}

@media only screen and (min-width : 321px) and (max-width : 600px) {
	.maps{
		width:100%;
	}
}
</style>
<div id="store_h">
	<c:forEach items="${storelist}" var="store">
		<input type="hidden" value="${store.store_code}">
	</c:forEach>
</div>
<div class="container storeform center-align">
	<c:choose>
		<c:when test="${storelist != null}">
			<ul class="collapsible" data-collapsible="accordion">
				<c:forEach items="${storelist}" var="store">
				<li id='${store.store_code}' class="on">
			      <div class="collapsible-header"><i class="material-icons">filter_drama</i><h5>${store.store_name}</h5></div>
			      <div class="collapsible-body">
			      	<div class="container" id="${store.store_code}">
				      	<div class="container" id="${store.store_code}">
			      	  <div class="row">
				      	<ul id="tabs-swipe-demo" class="tabs">
						    <li class="tab col s3"><a class="active" href="#${store.store_code}store_info">상가정보</a></li>
						    <li class="tab col s3"><a  href="#${store.store_code}menu_info">메뉴정보</a></li>
						    <li class="tab col s3"><a  href="#${store.store_code}event_info">행사정보</a></li>
						   
						 </ul>
					 <div id="${store.store_code}store_info" class="col s12">
				      	<table class="centered " style="margin-bottom:20px;" >
				      		<tr>
					      		<th>상점코드</th>
					      		<td>${store.store_code }</td>
				      		</tr>
				      		<tr>
					      		<th>사업자번호</th>
					      		<td>${store.business_code }</td>
				      		</tr>
				      		<tr>
					      		<th>영업시간</th>
					      		<td>${store.operating_time }</td>
				      		</tr>
				      		<tr>
					      		<th>캡쳐 횟수</th>
					      		<td>${store.view_count}</td>
				      		</tr>
				      		<tr>
					      		<th>상가 위치</th>
					      		<td class="${store.store_code }address" >${loclist.get(store.store_code).address}</td>
				      		</tr>
				      	</table>
				      	<center>
				     	 	<div class="maps" id="map${store.store_code}"></div>
				      	</center>
				      	<input type="button" value="상가관리" class="btn blue" onclick="store_modal(${store.store_code})">
				      </div>
				      	
				      <div id="${store.store_code}menu_info" class="col s12 ">
				      <label>메뉴종류</label>
					 	<center>
							<select class="browser-default" id="menu_type" style="width:30%" name="${store.store_code}">
									<c:forEach items="${menutype }" var="mtype">
										<c:set value="${mtype.key }" var="mkey"/>
										<c:set value="${store.store_code}" var="stkey"/>
										<c:if test="${mkey eq stkey}">
											<c:forEach items="${mtype.value}" var="mt">
					   							<option value="${mkey}${mt}">${mt}</option>
											</c:forEach>
				   						</c:if>
			   						</c:forEach>
				 			</select>
						</center>
				      	<table class="centered highlight" >
							<thead>
								<tr>
									<th>메뉴타입</th>
									<th>메뉴이름</th>
									<th>가격(원)</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${menulist }" var="mlist">
								<c:set value="${mlist.key }" var="key"/>
								<c:set value="${store.store_code}" var="storee"/>
								<c:if test="${key eq storee}">
									<c:forEach items="${mlist.value }" var="mvo">
										<tr class="${store.store_code}menu_list hidemenu" name="${store.store_code}${mvo.menu_type}">
											<td>${mvo.menu_type }</td>
											<td>${mvo.menu_name }</td>
											<td>${mvo.menu_price }</td>
										</tr>
									</c:forEach>
								</c:if>
							</c:forEach>
							</tbody>
						</table>
						
				      	<input type="button" value="메뉴관리" class="btn blue" onclick="menu_modal(${store.store_code})">
						</div>
						
						<div id="${store.store_code}event_info" class="col s12 ">
				      	<table class="centered highlight" >
							<thead>
								<tr>
									<th>진행상태</th>
									<th>행사내용</th>
									<th>기간</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${couponlist }" var="clist">
								<c:set value="${clist.key }" var="key"/>
								<c:set value="${store.store_code}" var="storee"/>
								<c:if test="${key eq storee}">
									<c:forEach items="${clist.value }" var="cvo">
										<tr>
											<td>${cvo.state }</td>
											<td>${cvo.contents }</td>
											<td>${cvo.s_time }  ~  ${cvo.e_time }</td>
										</tr>
									</c:forEach>
								</c:if>
							</c:forEach>
							</tbody>
						</table>
						
				      	<input type="button" value="행사관리" class="btn blue" onclick="coupon_modal(${store.store_code})">
						</div>
						
					</div>
				</div>
			      </div>
			    </li>
				</c:forEach>
			  </ul>
		</c:when>
		<c:otherwise>
			<div class="empt">
				<h3>등록된 상가 정보가 없습니다.</h3>
				<h5>상가를 등록하시겠습니까?</h5>
				<input type="button" class="btn" value="간판등록하기" id="enroll"><br>
			</div>
		</c:otherwise>
	</c:choose>
	
</div>
<script type="text/javascript">
function menu_modal(store_code){
	$('#'+store_code+"modal_menu").modal('open');
}
	
function store_modal(store_code){
	$('#'+store_code+"modal_store").modal('open');
}
function coupon_modal(store_code){
	console.log(store_code);
	$('#'+store_code+"modal_coupon").modal('open');
}
$(document).ready(function() {

	$("#fileupload").on('click',function(){
		$('#modal1').modal('open');
	});

	$("#enroll").on('click',function(){
		$(location).attr('href','enroll.whame');
	});

	$('input[value=메뉴관리]').on('click',function(){
		var store_code = $(this).parent().attr('id');
		$('#'+store_code+"modal_menu").modal('open');
	});

	$('input[value=상가수정]').on('click',function(){
		var store_code = $(this).parent().attr('id');
		$('#'+store_code+"modal_store").modal('open');
	});

	var test = 0;
	$('li[class=on]').on('click',function(){
		var store_code = $(this).attr('id');
		var store_name = $('li[id='+store_code+']').children().children('h5').html();
		var address = $('.'+store_code+'address').html();

		var mapContainer = document.getElementById('map'+store_code), // 지도를 표시할 div 
		mapOption = {
			center : new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			draggable :false,
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
									content : '<div style="width:150px;text-align:center;padding:6px 0;">'+store_name+'</div>'
								});
						infowindow.open(map, marker);
						// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
						map.setCenter(coords);
					}
				});
	});

	var selecttype;
	$('select#menu_type').each(function(){
		var store_code = $(this).attr('name');
		selecttype = $(this).val();
		$('tr[class='+store_code+'menu_list]').addClass('hidemenu');
		var check = /[&]/gi;
		if(check.test(selecttype) == true){
			$('tr[name='+store_code+'커피\\&라떼]').removeClass('hidemenu');
		}else{
			$('tr[name='+selecttype+']').removeClass('hidemenu');
		}
	});
	
	$('select#menu_type').on('change',function(){
		var store_code = $(this).attr('name');
		selecttype = $(this).val();
		$('tr[class='+store_code+'menu_list]').addClass('hidemenu');
		var check = /[&]/gi;
		if(check.test(selecttype) == true){
			$('tr[name='+store_code+'커피\\&라떼]').removeClass('hidemenu');
		}else{
			$('tr[name='+selecttype+']').removeClass('hidemenu');
		}
	});

})
</script>
