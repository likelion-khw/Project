<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@include file="../modal/show_coupon_modal.jsp" %>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=
6ae58faecc0e06a5ecbf63977aa440b0&libraries=services"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js"></script>
<style>
.dot {overflow:hidden;float:left;width:12px;height:12px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');}    
.dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#fff;}
.dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}    
.number {font-weight:bold;color:#ee6152;}
.dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
.distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
.distanceInfo .label {display:inline-block;width:50px;}
.distanceInfo:after {content:none;}
/*  크롤링 결과 디자인  */
div.thumb img{
	width: 90px;
	height: 90px;
	border-radius: 50px;
}
ul.review li{
	border: 1px #e0e0e0 solid;
    border-radius: 25px;
    padding:15px;
    margin-bottom: 15px;
}
/* ul.review.row .col{
	padding : 15px;
} */
ul.review .thumb_num{
	display:none;
}
ul.review .scial{
	display:none;
}
ul.review .txt_block{
	display:none;
}
ul.review .txt_inline{
	margin-left:0px;
}
ul.review .sh_blog_passage{
	margin-left:0px;
}

ul.review dt{
	height: 45px;
}

.crawhide{
	display:none;
}

div.keyword{
	width:80%;
	border: 2px #424242 solid;
    border-radius: 25px;
    margin-bottom:10px;
}
div.keyword li{
	list-style: none;
}

div.keyword h5{
	font-size: 19px;
	font-weight: bold;
}
div.keyword strong{
	font-size:14px;
	background-color: #3949ab;
	color:white;
	padding:5px;
	border-radius: 50px;
}
div.txt{
	margin:3px;
	font-size:12px;
}
/* -------------------- */
.showinfoform{
	margin-top:5%;
	width:85%;
	padding:20px;
	margin-bottom:5%;
	border-radius:20px;
}
.showinfo_card{
	width:60%;
}
.showinfo_menu{
	width:100%;
	margin-left:auto;
	margin-right: auto;
}

.hidemenu{
	display: none;
}

div.showinfo_btn input{
	margin-bottom: 5px;
}
.parallax-container {
    height: 300px;
}

@media only screen and (min-width : 300px) and (max-width : 600px) {

	.showinfoform{
	width:90%;
	padding:20px;
	}
	.showinfo_card{
		width:60%;
	}
	.showinfo_menu{
		width:100%;
		margin-left:auto;
		margin-right: auto;
	}
	.parallax img{
		width: 130%;
	}
	.parallax-container {
    	height: 200px;
	}
	.card .card-title{
		font-size: 18px;
	}
}

@media only screen and (min-width : 601px){
	ul.review li{
		height:455px;
	}
	ul.review dt{
		height: 60px;
	}
}
@media only screen and (min-width : 993px){
	ul.review li{
		height:505px;
	}
}
@media only screen and (min-width : 1360px){
	ul.review li{
		height:430px;
	}
}
</style>
<div class="container z-depth-3 showinfoform">
	<div class="center-align">
		<div class="parallax-container" style="border-radius:20px;">
		<div class="parallax"><img src="${store.store_image}" width="100%"></div>
		<div style="background-color: gray; opacity:0.8; bottom: 0px; width:100%; position: absolute;">
			<h4 style="color:white">${store.store_name} 메뉴</h4>
		</div>
		</div>
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
				
				<div class="pagzing">
					 <ul class="pagination" id="pagzing">
					 </ul>
				</div>
			</div>
			<div class="row">
				<div class="showinfo_card center-align col s12 m6">
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
					<c:choose>
						<c:when test="${crawl2 != null}">
						<div class="showinfo_btn center-align col s12 m6">
							<center>
								<div class="keyword">
									<h5>테마키워드</h5>
								 	${crawl2}
								</div>
							</center>
						<input type="button" value="이벤트보기" class="btn blue hidemenu" id="show_coupon"><br>
						<input type="button" value="재 검색" class="btn green" id="re_search"><br>
						<input type="button" value="메인이동" class="btn red" id="main_load"><br>
						<a id="kakao-link-btn" href="javascript:sendLink()">
							<img width="35px" src="//dev.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png"/>
						</a>
						</div>
						</c:when>
						<c:otherwise>
						<div class="showinfo_btn center-align col s12 m6" style="margin-top:10%;">
						<input type="button" value="이벤트보기" class="btn blue hidemenu" id="show_coupon"><br>
						<input type="button" value="재 검색" class="btn green" id="re_search"><br>
						<input type="button" value="메인이동" class="btn red" id="main_load"><br>
						<a id="kakao-link-btn" href="javascript:sendLink()">
							<img width="35px" src="//dev.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png"/>
						</a>
						</div>
						</c:otherwise>
					</c:choose>
					<c:if test="${fn:length(crawl3)==7}">
						<div style="width:200px; margin-left:auto;margin-right:auto;">
							<canvas id="myChart" width="100" height="100"></canvas>
						</div>
					</c:if>
					<c:if test="${crawl3 != null}">
						<div style="width:200px; display:none;">
							<canvas id="myChart" width="100" height="100"></canvas>
						</div>
					</c:if>
				</div>
			</div>
			<div class="center-align">
				<h5>추천 블로그</h5>
				<ul class="review row">
					<c:forEach items="${crawl}" var="craw">
						<div class="onepage col s12 m6 l4" name="blogs">
							${craw}
							</li>
						</div>
					</c:forEach>
					<c:forEach items="${crawl1}" var="craw1">
						<div class="twopage col s12 m6 l4" name="blogs">
							${craw1}
							</li>
						</div>
					</c:forEach>
				</ul>
				<span id="blog"><a href="javascript:;" id="showcrawl"><i class="material-icons large" style="color:black">arrow_drop_down</i></a></span>
				<!-- <input type="button" class="btn" value="접기" id="hidecrawl" style="float:right"> -->
			</div>
			 <div class="fixed-action-btn horizontal">
			    <a class="btn-floating btn-large white" id="upview" href="#top_view">
			      <i class="material-icons" style="color:black">arrow_upward</i>
			    </a>
			 </div>
</div>
<script type="text/javascript">
	$('ul.review div[name=blogs] dt').after('<p style=\"border:1px gray solid; margin-left:20%;margin-right:20%;margin-top:5px;margin-bottom:5px;\">');
	$('ul.review dd.txt_inline').css('color','pink');
	$('div[name=blogs] li.sh_blog_top').each(function(i){
		var thumb = $(this).children('div.thumb').html();

		var bloger = $(this).children('dl').children('dd.txt_block').children().children('a.txt84').html();
		var url = $(this).children('dl').children('dd.txt_block').children().children('a.url').html().split('/')[0];

		$(this).append('<p style=\"border:1px #e0e0e0 solid; margin-left:30%;margin-right:30%;margin-top:5px;margin-bottom:15px;\">');
		$(this).append("<span style=\"color:#ff4081\">By. "+"</span>"+bloger+"<br>");
		$(this).append("<span style=\"color:#ff4081\">FROM. "+"</span>"+url);
		
		if(thumb == null)
			{
				var href = $(this).children('dl').children().children().attr('href');
				$(this).prepend('<div class=\"thumb thumb-rollover\"><a href=\"'+href+'\" target=\"_blank\"><img src=\"resources/img/no-thumb.png"></a></div>');
			}
	});
	var crawmax = $('div.onepage li.sh_blog_top').length;
	var crawmax1 = $('div.twopage li.sh_blog_top').length;
	var crawstart = 7;
	var crawstart1 = 3;
	
	for(var i=4; i<=crawmax; i++){
		$('ul.review div.onepage li#sp_blog_'+i).addClass('crawhide');
	}
	
	for(var i=1; i<=crawmax1; i++){
		$('ul.review div.twopage li#sp_blog_'+i).addClass('crawhide');
	}

	var datat = new Array();
	
	<c:forEach items="${crawl3}" var="craw" begin="0" end="5">
		datat.push(parseInt('${craw}'));
	</c:forEach>
	
	var ctx = document.getElementById("myChart");
	var myChart = new Chart(ctx, {
	    type: 'bar',
	    data: {
	        labels: ["10대", "20대", "30대", "40대", "50대", "60대"],
	        datasets: [{
	            label:'연령별',
	            data: datat,
	            backgroundColor: [
	                'rgba(255, 99, 132, 0.8)',
	                'rgba(54, 162, 235, 0.8)',
	                'rgba(255, 206, 86, 0.8)',
	                'rgba(75, 192, 192, 0.8)',
	                'rgba(153, 102, 255, 0.8)',
	                'rgba(255, 159, 64, 0.8)'
	            ],
	            borderColor: [
	                'rgba(255,99,132,1)',
	                'rgba(54, 162, 235, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(153, 102, 255, 1)',
	                'rgba(255, 159, 64, 1)'
	            ],
	            borderWidth: 2
	        }]
	    },
	    options: {
	    	title: {
	            display: true,
	            text: '연령별 검색 인기도'
	        },
	        scales: {
	            yAxes: [{
	                ticks: {
	                    beginAtZero:true,
	                    suggestedMax: 100
	                }
	            }]
	        }
	    }
	});
$(document).ready(function() {
		$('.parallax').parallax();
		$('#showcrawl').on('click',function(){
			if(crawstart > crawmax){
				if(crawstart1 >= crawmax1)
					{
						crawstart1 = crawmax1;
						$('ul.review div.twopage li#sp_blog_'+10).removeClass('crawhide');
						$('#blog').css('display','none');
						
					}
				$('ul.review div.onepage li#sp_blog_'+10).removeClass('crawhide');
				for(var i=1; i<crawstart1; i++){
					$('ul.review div.twopage li#sp_blog_'+i).removeClass('crawhide');
				}
				crawstart1 += 3;
			}else{
				for(var i=1; i<crawstart; i++){
					$('ul.review div.onepage li#sp_blog_'+i).removeClass('crawhide');
				}
				crawstart += 3;
			}
		});

		$('#hidecrawl').on('click',function(){
			for(var i=4; i<=crawmax; i++){
				$('ul.review div.onepage li#sp_blog_'+i).addClass('crawhide');
			}
			crawstart = 7;
			for(var i=1; i<=crawmax1; i++){
				$('ul.review div.twopage li#sp_blog_'+i).addClass('crawhide');
			}
			crawstart1 = 3;		
		});
	
		var coupon= false;
		<c:forEach items="${couponlist}" var="coupon">
			if("${coupon.state}" == '진행중' || "${coupon.state}" == '예정'){
				coupon=true;
			}
		</c:forEach>
		if( coupon == true)
			{
				$("#coupon1").modal('open');
				$('input[value="이벤트보기"]').removeClass('hidemenu');
			}


		/* 다음맵 관련 --------------------------------------  */
		var latlon;
		var address = '${location.address}';

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};
		// 지도를 생성합니다    
		var map = new daum.maps.Map(mapContainer, mapOption);

		var imageSrc = 'resources/img/me.png', // 마커이미지의 주소입니다    
	    imageSize = new daum.maps.Size(40, 40), // 마커이미지의 크기입니다
	    imageOption = {offset: new daum.maps.Point(20, 20)};
	      
		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize,imageOption),
		    markerPosition = new daum.maps.LatLng('${loca[0]}', '${loca[1]}'); // 마커가 표시될 위치입니다
	
		// 마커를 생성합니다
		var markerME = new daum.maps.Marker({
		    position: markerPosition, 
		    image: markerImage // 마커이미지 설정 
		});
	
		// 마커가 지도 위에 표시되도록 설정합니다
		markerME.setMap(map);  
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
						latlon = new daum.maps.LatLng(
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
						load();
					}
				});

		var drawingFlag = false; // 선이 그려지고 있는 상태를 가지고 있을 변수입니다
		var moveLine; // 선이 그려지고 있을때 마우스 움직임에 따라 그려질 선 객체 입니다
		var clickLine // 마우스로 클릭한 좌표로 그려질 선 객체입니다
		var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다
		var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.


		    // 마우스로 클릭한 위치입니다 
		    var clickPosition = new daum.maps.LatLng('${loca[0]}', '${loca[1]}');
		    
		        // 상태를 true로, 선이 그리고있는 상태로 변경합니다
		        drawingFlag = true;
		        
		        // 지도 위에 선이 표시되고 있다면 지도에서 제거합니다
		        deleteClickLine();
		        
		        // 지도 위에 커스텀오버레이가 표시되고 있다면 지도에서 제거합니다
		        deleteDistnce();

		        // 지도 위에 선을 그리기 위해 클릭한 지점과 해당 지점의 거리정보가 표시되고 있다면 지도에서 제거합니다
		        deleteCircleDot();
		    
		        // 클릭한 위치를 기준으로 선을 생성하고 지도위에 표시합니다
		        clickLine = new daum.maps.Polyline({
		            map: map, // 선을 표시할 지도입니다 
		            path: [clickPosition], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
		            strokeWeight: 3, // 선의 두께입니다 
		            strokeColor: '#db4040', // 선의 색깔입니다
		            strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
		            strokeStyle: 'solid' // 선의 스타일입니다
		        });
		        
		        // 선이 그려지고 있을 때 마우스 움직임에 따라 선이 그려질 위치를 표시할 선을 생성합니다
		        moveLine = new daum.maps.Polyline({
		            strokeWeight: 3, // 선의 두께입니다 
		            strokeColor: '#db4040', // 선의 색깔입니다
		            strokeOpacity: 0.5, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
		            strokeStyle: 'solid' // 선의 스타일입니다    
		        });
		    
		        // 클릭한 지점에 대한 정보를 지도에 표시합니다
		        displayCircleDot(clickPosition, 0);

		    
		// 지도에 마우스무브 이벤트를 등록합니다
		// 선을 그리고있는 상태에서 마우스무브 이벤트가 발생하면 그려질 선의 위치를 동적으로 보여주도록 합니다
		/* daum.maps.event.addListener(map, 'mousemove', function () { */
		function load(){
		    // 지도 마우스무브 이벤트가 발생했는데 선을 그리고있는 상태이면
		    if (drawingFlag){
		        
		        // 마우스 커서의 현재 위치를 얻어옵니다 
		        var mousePosition = latlon; 

		        // 마우스 클릭으로 그려진 선의 좌표 배열을 얻어옵니다
		        var path = clickLine.getPath();
		        
		        // 마우스 클릭으로 그려진 마지막 좌표와 마우스 커서 위치의 좌표로 선을 표시합니다
		        var movepath = [path[path.length-1], mousePosition];
		        moveLine.setPath(movepath);    
		        moveLine.setMap(map);
		        
		        var distance = Math.round(clickLine.getLength() + moveLine.getLength()), // 선의 총 거리를 계산합니다
		            content = getTimeHTML(distance);
		        
		        // 거리정보를 지도에 표시합니다
		        showDistance(content, mousePosition);   
		    }             
		};                 

		// 지도에 마우스 오른쪽 클릭 이벤트를 등록합니다
		// 선을 그리고있는 상태에서 마우스 오른쪽 클릭 이벤트가 발생하면 선 그리기를 종료합니다
		daum.maps.event.addListener(map, 'rightclick', function (mouseEvent) {

		    // 지도 오른쪽 클릭 이벤트가 발생했는데 선을 그리고있는 상태이면
		    if (drawingFlag) {
		        
		        // 마우스무브로 그려진 선은 지도에서 제거합니다
		        moveLine.setMap(null);
		        moveLine = null;  
		        
		        // 마우스 클릭으로 그린 선의 좌표 배열을 얻어옵니다
		        var path = clickLine.getPath();
		    
		        // 선을 구성하는 좌표의 개수가 2개 이상이면
		        if (path.length > 1) {

		            // 마지막 클릭 지점에 대한 거리 정보 커스텀 오버레이를 지웁니다
		            if (dots[dots.length-1].distance) {
		                dots[dots.length-1].distance.setMap(null);
		                dots[dots.length-1].distance = null;    
		            }

		            var distance = Math.round(clickLine.getLength()), // 선의 총 거리를 계산합니다
		                content = getTimeHTML(distance); // 커스텀오버레이에 추가될 내용입니다
		                
		            // 그려진 선의 거리정보를 지도에 표시합니다
		            showDistance(content, path[path.length-1]);  
		             
		        } else {

		            // 선을 구성하는 좌표의 개수가 1개 이하이면 
		            // 지도에 표시되고 있는 선과 정보들을 지도에서 제거합니다.
		            deleteClickLine();
		            deleteCircleDot(); 
		            deleteDistnce();

		        }
		        
		        // 상태를 false로, 그리지 않고 있는 상태로 변경합니다
		        drawingFlag = false;          
		    }  
		});    

		// 클릭으로 그려진 선을 지도에서 제거하는 함수입니다
		function deleteClickLine() {
		    if (clickLine) {
		        clickLine.setMap(null);    
		        clickLine = null;        
		    }
		}

		// 마우스 드래그로 그려지고 있는 선의 총거리 정보를 표시하거
		// 마우스 오른쪽 클릭으로 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 생성하고 지도에 표시하는 함수입니다
		function showDistance(content, position) {
		    
		    if (distanceOverlay) { // 커스텀오버레이가 생성된 상태이면
		        
		        // 커스텀 오버레이의 위치와 표시할 내용을 설정합니다
		        distanceOverlay.setPosition(position);
		        distanceOverlay.setContent(content);
		        
		    } else { // 커스텀 오버레이가 생성되지 않은 상태이면
		        
		        // 커스텀 오버레이를 생성하고 지도에 표시합니다
		        distanceOverlay = new daum.maps.CustomOverlay({
		            map: map, // 커스텀오버레이를 표시할 지도입니다
		            content: content,  // 커스텀오버레이에 표시할 내용입니다
		            position: position, // 커스텀오버레이를 표시할 위치입니다.
		            xAnchor: 0,
		            yAnchor: 0,
		            zIndex: 3  
		        });      
		    }
		}

		// 그려지고 있는 선의 총거리 정보와 
		// 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 삭제하는 함수입니다
		function deleteDistnce () {
		    if (distanceOverlay) {
		        distanceOverlay.setMap(null);
		        distanceOverlay = null;
		    }
		}

		// 선이 그려지고 있는 상태일 때 지도를 클릭하면 호출하여 
		// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 표출하는 함수입니다
		function displayCircleDot(position, distance) {

		    // 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
		    var circleOverlay = new daum.maps.CustomOverlay({
		        content: '<span class="dot"></span>',
		        position: position,
		        zIndex: 1
		    });

		    // 지도에 표시합니다
		    circleOverlay.setMap(map);

		    if (distance > 0) {
		        // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
		        var distanceOverlay = new daum.maps.CustomOverlay({
		            content: '<div class="dotOverlay">거리 <span class="number">' + distance + '</span>m</div>',
		            position: position,
		            yAnchor: 1,
		            zIndex: 2
		        });

		        // 지도에 표시합니다
		        distanceOverlay.setMap(map);
		    }

		    // 배열에 추가합니다
		    dots.push({circle:circleOverlay, distance: distanceOverlay});
		}

		// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 지도에서 모두 제거하는 함수입니다
		function deleteCircleDot() {
		    var i;

		    for ( i = 0; i < dots.length; i++ ){
		        if (dots[i].circle) { 
		            dots[i].circle.setMap(null);
		        }

		        if (dots[i].distance) {
		            dots[i].distance.setMap(null);
		        }
		    }

		    dots = [];
		}

		// 마우스 우클릭 하여 선 그리기가 종료됐을 때 호출하여 
		// 그려진 선의 총거리 정보와 거리에 대한 도보, 자전거 시간을 계산하여
		// HTML Content를 만들어 리턴하는 함수입니다
		function getTimeHTML(distance) {

		    // 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
		    var walkkTime = distance / 67 | 0;
		    var walkHour = '', walkMin = '';

		    // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
		    if (walkkTime > 60) {
		        walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
		    }
		    walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

		    // 자전거의 평균 시속은 16km/h 이고 이것을 기준으로 자전거의 분속은 267m/min입니다
		    var bycicleTime = distance / 227 | 0;
		    var bycicleHour = '', bycicleMin = '';

		    // 계산한 자전거 시간이 60분 보다 크면 시간으로 표출합니다
		    if (bycicleTime > 60) {
		        bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>시간 '
		    }
		    bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>분'

		    // 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
		    var content = '<ul class="dotOverlay distanceInfo">';
		    content += '    <li>';
		    content += '        <span class="label">총거리</span><span class="number">' + distance + '</span>m';
		    content += '    </li>';
		    content += '    <li>';
		    content += '        <span class="label">도보</span>' + walkHour + walkMin;
		    content += '    </li>';
		    content += '    <li>';
		    content += '        <span class="label">자전거</span>' + bycicleHour + bycicleMin;
		    content += '    </li>';
		    content += '</ul>'

		    return content;
		}

		/*--------------------------------  */

		$("#show_coupon").on('click',function(){
			$('#coupon1').modal('open');
		});

		$("#re_search").on('click',function(){
			$('#modal1').modal('open');
		});

		$("#main_load").on('click',function(){
			$(location).attr('href','/whame');
		});
		
		$('#menu_type:first-child').attr('selected');
		
		var selecttype = $('#menu_type').val();
		var check = /[&]/gi;
		if(check.test(selecttype) == true){
			var num = 0;
			var pagenum = parseInt($('tr#커피\\&라떼').length / 5);
			$('tr#커피\\&라떼').each(function(){
				if(num <= 4)
					{
						$(this).removeClass('hidemenu');
						num +=1;
					}
				else{
					return false;
				}
			});
			if(($('tr#커피\\&라떼').length % 5) != 0 )
				{
					pagenum += 1;
				}
			for(var i = 1; i <= pagenum; i++){
				$('ul#pagzing').append("<li name=\"pageing\" class=\"check\"><a href=\"javascript:ta\">"+i+"</a></li>");
			}
		}else{
			var num = 0;
			var pagenum = parseInt($('tr#'+selecttype).length / 5);
			$('tr#'+selecttype).each(function(){
				if(num <= 4)
					{
						$(this).removeClass('hidemenu');
						num +=1;
					}
				else{
					return false;
				}
			});
			if(($('tr#'+selecttype).length % 5) != 0 )
				{
					pagenum += 1;
				}
			for(var i = 1; i <= pagenum; i++){
				$('ul#pagzing').append("<li name=\"pageing\"><a href=\"javascript:ta\">"+i+"</a></li>");
			}
		}

		$(document).on('click','li[name=\'pageing\']',function(){
			var check = $(this).attr('class');
			$('tr[class=menu_list]').addClass('hidemenu');

			if( check != 'check'){
				var pagelast = ($(this).text() * 5);
				var pagefirst = pagelast - 5;
				var firstnum = 0;

				$('tr#'+selecttype).each(function(){
					if( firstnum < pagefirst)
						{
							firstnum += 1;
						}
					else{
							if(pagefirst < pagelast)
								{
									$(this).removeClass('hidemenu');
									pagefirst +=1;
									firstnum +=1;
								}
						}
				});
			}else{
				var pagelast = ($(this).text() * 5);
				var pagefirst = pagelast - 5;
				var firstnum = 0;

				$('tr#커피\\&라떼').each(function(){
					if( firstnum < pagefirst)
						{
							firstnum += 1;
						}
					else{
							if(pagefirst < pagelast)
								{
									$(this).removeClass('hidemenu');
									pagefirst +=1;
									firstnum +=1;
								}
						}
				});
			}
			
		});

		$('#menu_type').on('change',function(){
			$('ul#pagzing').html('');
			selecttype = $(this).val();
			$('tr[class=menu_list]').addClass('hidemenu');
			var check = /[&]/gi;
			if(check.test(selecttype) == true){
				var num = 0;
				var pagenum = parseInt($('tr#커피\\&라떼').length / 5);
				$('tr#커피\\&라떼').each(function(){
					if(num <= 4)
						{
							$(this).removeClass('hidemenu');
							num +=1;
						}
					else{
						return false;
					}
				});
				if(($('tr#커피\\&라떼').length % 5) != 0 )
					{
						pagenum += 1;
					}
				for(var i = 1; i <= pagenum; i++){
					$('ul#pagzing').append("<li name=\"pageing\" class=\"check\"><a href=\"javascript:ta\">"+i+"</a></li>");
				}
			}else{
				var num = 0;
				var pagenum = parseInt($('tr#'+selecttype).length / 5);
				$('tr#'+selecttype).each(function(){
					if(num <= 4)
						{
							$(this).removeClass('hidemenu');
							num +=1;
						}
					else{
						return false;
					}
				});
				if(($('tr#'+selecttype).length % 5) != 0 )
					{
						pagenum += 1;
					}
				for(var i = 1; i <= pagenum; i++){
					$('ul#pagzing').append("<li name=\"pageing\"><a href=\"javascript:ta\">"+i+"</a></li>");
				}
			}
		})

		
})
</script>

<script type="text/javascript">
$("#upview").click(function(event){            
    event.preventDefault();
    $('html,body').animate({scrollTop:$(this.hash).offset().top+1}, 500);
});

Kakao.init('f83177e46350e0d7ba18232a50b978ed');
// // 카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
   	function sendLink(){
   		Kakao.Link.createDefaultButton({
   	      container: '#kakao-link-btn',
   	      objectType: 'feed',
   	      content: {
   	    	title: '${store.store_name}',
   	    	description: '${location.address}',
   	    	imageUrl: '${store.store_image}',
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