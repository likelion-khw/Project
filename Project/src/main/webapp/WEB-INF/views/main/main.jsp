<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Compiled and minified JavaScript -->
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=
6ae58faecc0e06a5ecbf63977aa440b0&libraries=clusterer"></script>
<style type="text/css">
main{
	opacity : 0.1;
}
#menu{
		position: fixed;
		bottom:20px;
		float:right;
		right:20px;
	}
.mainform{
	padding-bottom: 20px;
	width: 100%;
	}
	
.mainimg{
	width:50%;
}
.main_text{
	padding:20px; width:80%; margin-top:20px;
	background-color: #f5f5f5;
	border-radius:40px;
}
.main_mapform{
	margin-bottom:10px;
	width:50%;
	padding:10px;
}
#main_map{
	margin-bottom: 20px;
	height: 300px;
}
.mainrun{
		width:100%;
		height: 270px;
}


/*  */
.carousel{
	height: 250px;
}
.carousel .carousel-item{
	opacity:1 !important;
	top:-40px;
}

.carousel .carousel-item div.row{
	 border-radius:20px; 
}

#content {
 margin:-1px;
 height: 650px;
 width:100%; 
}
#content div.trans{width: 100%; height: 650px;}
 
div.textt{
	padding-top:300px;
	text-align: center;
	width: 100%;
}

/*  */

@media only screen and (min-width : 321px) and (max-width : 600px) {
	.mainimg{
	width:100%;
	}
	.main_text p{
		font-size:13px;
	}
	.main_text h3{
		font-size:15px;
		font-weight: bolder;
	}
	.mainform input{ 
		margin-bottom:10px;
	}
	.main_text{
		width:90%;
	}
	 
	.main_mapform{
	width:90%;
	}
	.carousel .carousel-item .caro {
		 height: 100px; 
	}
}
</style>

<div id="content"> 
	<div class="active trans" style="background-image: url('resources/img/1.png'); background-size:cover;">
		<div class="textt">
		  	<span style="font-size: 40px; color:white; font-weight: bold;">What Menu?</span><br>
			<a href="#downf" id="down" class="btn red lighten-2" style="border-radius:20px;">START</a>
		</div>
	</div>
	<div class="trans" style="background-image: url('resources/img/2.png'); background-size:cover; display:none;">
		<div class="textt">
		  	<span style="font-size: 40px; color:white; font-weight: bold;">What Menu?</span><br>
			<a href="#downf" id="down" class="btn red lighten-2" style="border-radius:20px;">START</a>
		</div>
	</div>
	<div  class="trans" style="background-image: url('resources/img/3.png'); background-size:cover; display:none;">
		<div class="textt">
		  	<span style="font-size: 40px; color:white; font-weight: bold;">What Menu?</span><br>
			<a href="#downf" id="down" class="btn red lighten-2" style="border-radius:20px;">START</a>
		</div>
	</div>
</div>
	<div class="center-align row" style="padding:10px" id="downf">
		<div style="width: 50%; margin-left:auto; margin-right:auto;" >
			<input type="button" class="btn green col s12" value="메뉴찾기" id="fileupload" style="border-radius:20px; margin-bottom:7px; width:">
			<input type="button" class="btn pink darken-2 col s12" value="간판등록하기" id="enroll" style="border-radius:20px;"><br>
			<button  data-activates="search_cg" class="btn button-collapse search_cg" style="margin:7px;border-radius:20px; height:45px;"><i class="material-icons">search</i><span>주변검색</span></button>
		</div>
		<div class="main_text z-depth-1 row" style="margin-left:auto; margin-right: auto;">
			<div class="col s12">
			<img src="resources/img/main.png" class="mainimg" style="border-radius:150px">
			<h3>Whame란?</h3>
			<p>Whame는 'What Menu'에서 비롯된 타이틀입니다. </p>
			<p>상가의 메뉴를 직접 들어가지 않고 밖에서 간판 사진을 이용하여 메뉴정보를 얻을 수 있습니다.</p>
			</div>
		</div>
		<div style="width:90%; margin-left: auto; margin-right: auto;" class="z-depth-1 row">
			<div class="main_mapform col s12 m8">
				<div class="counter" data-count="000${count}" id="test"></div>
				<div id="main_map"></div>
			</div>
			<div class="col s12 m4">
				<h4>Top View</h4><a class="btn-floating red" id="me"><i class="material-icons">gps_fixed</i></a>
				<c:set var="count" value="1"/>
				<table class="centered highlight">
				<c:forEach items="${countrank}" var="rank" end="4">
				<tr id="${rank.store_code}" class="mover">
					<th><i class="material-icons" name="${count}rank">stars</i></th>
					<td>${count}위</td>
					<td style="width:50%;">${rank.store_name}</td>
					<td>${rank.view_count}</td>
					<c:set var="count" value="${count+1}"/>
				</tr>
				</c:forEach>
				</table>
			</div>
		</div>
		<div style="width: 100%; margin-left: auto; margin-right: auto;">
			<span style="font-size: 25px;">주변 신규 등록</span><span style="font-size: 13px;">(1km)</span>
			<div class="carousel" style="margin-top:40px;" id="newStore">
		 	 </div>
	 	</div>
	</div>
	
<a id="menu"><img src="resources/img/main.png" width="80px"></a>

<script type="text/javascript">
	$('i[name=1rank]').css('color','gold');
	$('i[name=2rank]').css('color','silver');
	$('i[name=3rank]').css('color','brown');
	
	var showImg, nextImg;

	function fadeInOut()
	{
	 //id가 content의 노드중  첫번째img(img:eq(0))를 showImg에 저장
	 showImg = $("#content div.trans:eq(0)");
	 //id가 content의 노드중  두번째img(img:eq(1))를 showImg에 저장
	 nextImg = $("#content div.trans:eq(1)");
	 //nextImg에 active클래스 적용
	 nextImg.addClass("active");
	 //nextImg를 처음에는 보이지 않게 처리
	    nextImg.css('display','')
	     //애니메이션 효과로 1초동안 opacity 값이 1로 변경되면서 나타난다.
	    //콜백함수 실행, 처음 보였던 이미지를 dic id="content" 안의 가장 마지막 노드로 이동시킨다.
	    $("#content").append(showImg);
	    //showImg에 적용되어 있던 active 클래스를 제거한다.
	    showImg.removeClass("active").css('display','none');
	}
	  
	 //2초 간격으로 fadeInOut()함수를 실행 시킨다.
	 var timer = setInterval("fadeInOut()",5000); 
	
	var cl = new Array();
	
	$(document).ready(function() {
		$('.geo_loding').css('display','inline');
		var counter = function(){
 			 $(".counter").rollingCounter({
 		        animate : true,
 		        attrCount : 'data-count',
 		        delayTime : 30 ,
 		        waitTime : 1 ,
 		        easing : 'easeOutBounce',
 		        duration : 1000
 		    });
	 	}();
	 	
		$("#fileupload").on('click',function(){
			$('#modal1').modal('open');
		});
	
		$("#enroll").on('click',function(event){
			var member = '${memberVO.userid}';
			if(member == "")
				{
					$('#sign_login').modal('open');
				}
			else{
				$(location).attr('href','enroll.whame');
			}
		});

		/* 좌표인식 */
		var lat;
		var lng;

		if (navigator.geolocation) 
		{
			navigator.geolocation.getCurrentPosition(showPosition,showError);
		}
		else
		{
			$('#container').append('<div class="error">위치정보를 사용 할 수 없는 환경입니다.</div>');
		}

		function showPosition(position) {
			$.when( 
				lat = position.coords.latitude,
				lng = position.coords.longitude
			).then(function(){
				mapstart(lat,lng);
				 $.ajax({
					  url : "getNewStore.whame",
					  type : 'post',
					  data : {'lat': lat, 'lon':lng},
					  success :function(result){
						  	for(var i = 0; i< result.length; i++){
							  	$('#newStore').html($('#newStore').html()+
							  		'<a class="carousel-item" style="width:250px; height:170px;" href="/whame/forkakao.whame?store_code='+result[i].store_code+'">'
								    	+'<div class="caro row" >'
								    		+'<div class="col s12 image" id="'+result[i].store_code+'">'
								    			+'<img src="'+result[i].store_image+'" width="227px" height="170px" style="border-radius:30px">'
								    		+'</div>'
								    		+'<div class="col s12"  style="height: 45px;">'
								    		+	'<span style="font-size: 17px; color:black">'+result[i].store_name+'</span>'
								    		+	'<span style="blue">('+result[i].dong+')</span>'
								    	+	'</div>'
								    	+	'<div class="col s12">'
								    	+		'<span style="blue">'+result[i].store_category+'</span>'
								    	+	'</div>'
								    	+'</div>'
									+  '</a>'
								);
							};

							startcarousel();

							$('.geo_loding').css('display','none');
							$('main').css('opacity','1');
					  }
					});
			});
		}

		function showError(error)
		{
			var no_text;
			lat = 37.520498;
			lng = 127.022959;
			mapstart(lat,lng);

			 $.ajax({
				  url : "getNewStore.whame",
				  type : 'post',
				  data : {'lat': lat, 'lon':lng},
				  success :function(result){
					  	for(var i = 0; i< result.length; i++){
						  	$('#newStore').html($('#newStore').html()+
						  		'<a class="carousel-item" style="width:250px; height:170px;" href="/whame/forkakao.whame?store_code='+result[i].store_code+'">'
							    	+'<div class="caro row" >'
							    		+'<div class="col s12 image" id="'+result[i].store_code+'">'
							    			+'<img src="'+result[i].store_image+'" width="227px" height="170px" style="border-radius:30px">'
							    		+'</div>'
							    		+'<div class="col s12"  style="height: 45px;">'
							    		+	'<span style="font-size: 17px; color:black">'+result[i].store_name+'</span>'
							    		+	'<span style="blue">('+result[i].dong+')</span>'
							    	+	'</div>'
							    	+	'<div class="col s12">'
							    	+		'<span style="blue">'+result[i].store_category+'</span>'
							    	+	'</div>'
							    	+'</div>'
								+  '</a>'
							);
						};

						startcarousel();
						$('.geo_loding').css('display','none');
						$('main').css('opacity','1');
				  }
				});
			switch (error.code)
			{
				case error.PERMISSION_DENIED:
					no_text = '위치정보 획득권한을 거부 당했습니다.<br />위치정보를 활용 할 수 있도록 허용 해주세요.';
				break;
				case error.POSITION_UNAVAILABLE:
					no_text = '위치정보를 사용 할 수 없습니다.<br />페이지를 다시 로드 해주세요.';
				break;
				case error.TIMEOUT:
					no_text = '위치정보 요청시간이 지났습니다.<br />페이지를 다시 로드 해주세요.';
				break;
				default:
					no_text = '알 수없는 오류가 발생했습니다.<br />페이지를 다시 로드 해주세요.';
				break;
			};
		} 

		var container = document.getElementById('main_map');
		var options;
		var map;
		
		function mapstart(lat,lng){
			options = {
				center: new daum.maps.LatLng(lat,lng),
				level: 4
			};
			
			map = new daum.maps.Map(container, options);

			var imageSrc = 'resources/img/me.png', // 마커이미지의 주소입니다    
			    imageSize = new daum.maps.Size(40, 40), // 마커이미지의 크기입니다
			    imageOption = {offset: new daum.maps.Point(20, 20)};
			      
			// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
			var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize,imageOption),
			    markerPosition = new daum.maps.LatLng(lat, lng); // 마커가 표시될 위치입니다
	
			// 마커를 생성합니다
			var markerME = new daum.maps.Marker({
			    position: markerPosition, 
			    image: markerImage // 마커이미지 설정 
			});
	
			// 마커가 지도 위에 표시되도록 설정합니다
			markerME.setMap(map);  
	
			var clusterer = new daum.maps.MarkerClusterer({
		        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
		        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
		        minLevel: 5 // 클러스터 할 최소 지도 레벨 
		    });

			function makeOverListener(map, marker, infowindow) {
			    return function() {
			        infowindow.open(map, marker);
			    };
			}

			// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
			function makeOutListener(infowindow) {
			    return function() {
			        infowindow.close();
			    };
			}

			var markers = new Array();
			
			<c:forEach items="${locationlist}" var="lo">
				var marker = new daum.maps.Marker({
					  position: new daum.maps.LatLng('${lo.lat}','${lo.lon}')
				  });
	
					var infowindow = new daum.maps.InfoWindow({
				        content: '<div style="padding:5px;width:100%;" class="info_map container">'+
					        	'<div class="center-align" style="width:100%;">${lo.store_name}</div>'+
			        			'</div>'// 인포윈도우에 표시할 내용
				    });
				daum.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
			    daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));

				  markers.push(marker);
			</c:forEach>
	
			clusterer.addMarkers(markers);

	 		$('tr[class=mover]').on('mouseover',function(){
				var id = $(this).attr('id');
				<c:forEach items="${locationlist}" var="lo2">
					if('${lo2.store_code}' == id)
						{
							var moveLatLon = new daum.maps.LatLng('${lo2.lat}','${lo2.lon}');
							map.panTo(moveLatLon);
						}				  
				</c:forEach>
			});
	
			$('tr[class=mover]').on('click',function(){
				var id = $(this).attr('id');
				
				<c:forEach items="${locationlist}" var="lo2">
					if('${lo2.store_code}' == id)
						{
						var points = [
										new daum.maps.LatLng('${lo2.lat}','${lo2.lon}')
						          ];
	
						          // 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
						          var bounds = new daum.maps.LatLngBounds();    
	
						          var i, marker;
						          for (i = 0; i < points.length; i++) {
						              // 배열의 좌표들이 잘 보이게 마커를 지도에 추가합니다
						              marker =  new daum.maps.Marker({ position : points[i] });
						              marker.setMap(map);
						              
						              // LatLngBounds 객체에 좌표를 추가합니다
						              bounds.extend(points[i]);
						          }
	
						          map.setBounds(bounds);
						}				  
				</c:forEach>
			}); 
		};

		$('#me').on('click',function(){
			    // 이동할 위도 경도 위치를 생성합니다 
			    var moveLatLon = new daum.maps.LatLng(lat, lng);
			    // 지도 중심을 부드럽게 이동시킵니다
			    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
			    map.panTo(moveLatLon);            
		});
		/* ---------------- */
	    $("a#down").click(function(event){            
	        event.preventDefault();
	        $('html,body').animate({scrollTop:$(this.hash).offset().top+1}, 1000);
		});

		function startcarousel(){
		    $('.carousel').carousel({
		          dist:0,
		          shift:0,
		          padding:-5
		    });
		}

		setInterval(function(){
	    	$('.carousel').carousel('next');
		    },2000);

	    function stopScroll(){
	    	clearInterval(v);
	    	$('.carousel').carousel({
	    		time_constant : 0
	    	});
	    }
	     var fingerMove = false;
	     
	     $('.carousel-item .row .image').bind('touchstart click', function(e) {
			//e.preventDefault();	//	이벤트취소.
			fingerMove = false;
		});

		$('.carousel-item .row .image').bind('touchmove', function(e) {
			//e.preventDefault();
			fingerMove = true;
		});

		$('.carousel-item .row .image').bind('touchend', function(e) {
			//e.preventDefault(); 
			var store_code = $(this).attr('id');
			if(fingerMove == false){
				location.href='/whame/forkakao.whame?store_code='+store_code;
				
			}
		}); 

		 $('.button-collapse.search_cg').sideNav({
		      menuWidth: 330, // Default is 300
		      edge: 'bottom', // Choose the horizontal origin
		      closeOnClick: true, // Closes side-nav on <a> clicks, useful for Angular/Meteor
		      draggable: true // Choose whether you can drag to open on touch screens
		    }
		  );


	});
</script>

