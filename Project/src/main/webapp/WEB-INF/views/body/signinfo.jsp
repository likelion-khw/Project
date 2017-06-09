<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../modal/fileupload_modal.jsp" %>
<%@include file="../modal/show_coupon_modal.jsp" %>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=de8ef5ba97a6ddfb7081ba88f3c350e9&libraries=services"></script>
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
	<c:choose>
		<c:when test="${error != null}">
			<h3>${error}</h3>
		</c:when>
		<c:otherwise>
			<h4>${store.store_name} 메뉴</h4>
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
				<input type="button" value="이벤트보기" class="btn blue hidemenu" id="show_coupon"><br><br>
				<input type="button" value="재 검색" class="btn green" id="re_search"><br><br>
				<c:if test="${memberVO.userid != null}">
					<input type="button" value="히스토리" class="btn brown" id="history_load"><br><br>
				</c:if>
				<input type="button" value="메인이동" class="btn red" id="main_load"><br><br>
				<a id="kakao-link-btn" href="javascript:sendLink()">
					<img width="50px" src="//dev.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png"/>
				</a>
			</div>
		</c:otherwise>
	</c:choose>
</div>

<script type="text/javascript">
$(document).ready(function() {
	var coupon = '${couponlist}';
	console.log("쿠폰존재여부"+coupon.length);
	if(coupon.length-2 > 0){
		$('#coupon1').openModal();
		$('input[value="이벤트보기"]').removeClass('hidemenu');
		
	}
		var user = '${memberVO.userid}';
		var error = '${error}';
		if(user != '')
			{
				if(error == ''){
					 Materialize.toast('검색 정보가 히스토리에 저장됩니다.', 4000, 'rounded')
				}
			}
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

		
		$("#show_coupon").on('click',function(){
			$('#coupon1').modal('open');
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
		
		$('#menu_type:first-child').attr('selected');
		var selecttype = $('#menu_type').val();
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

<script type="text/javascript">
Kakao.init('f83177e46350e0d7ba18232a50b978ed');
// // 카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
   	function sendLink(){
   		Kakao.Link.createDefaultButton({
   	      container: '#kakao-link-btn',
   	      objectType: 'feed',
   	      content: {
   	    	title: '${store.store_name}',
   	    	description: '${location.address}',
   	    	imageUrl: 'http://s3-ap-northeast-1.amazonaws.com/whame01/StoreTitle/${imgurl}',
   	    	link: {
   	    	  mobileWebUrl: 'http://192.168.1.38:8080/whame/forkakao.whame?store_code=${store.store_code}',
   	    	  webUrl: 'http://192.168.1.38:8080/whame/forkakao.whame?store_code=${store.store_code}'
   	    	}
   	      },
   	      social: {
   	    	likeCount: ${store.view_count},
   	      },
   	      buttons: [{
   	    	title: '상세보기',
   	    	link: {
   	    	  mobileWebUrl: 'http://192.168.1.38:8080/whame/forkakao.whame?store_code=${store.store_code}',
   	    	  webUrl: 'http://192.168.1.38:8080/whame/forkakao.whame?store_code=${store.store_code}'
   	        }
   	      }]
   	    });
	    }
</script>