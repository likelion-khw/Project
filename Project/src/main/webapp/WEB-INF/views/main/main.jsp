<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../modal/fileupload_modal.jsp" %>
<!-- Compiled and minified JavaScript -->
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=
f0f441314c4cc2b255e1663dc273009f&libraries=services"></script>
<style type="text/css">
.mainform{
	margin-top: 20px;
	padding-top: 20px;
	padding-bottom: 20px;
	width: 90%;
	}
	
.mainimg{
	width:50%;
}
.main_text{
	padding:20px; width:80%; margin-top:20px;
	background-color: #f5f5f5;
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
	.counter .digit{
		width:23px;
	}
}
</style>

<div class="container mainform z-depth-3">
	<div class="center-align row" style="padding:10px">
		<input type="button" class="btn green" value="메뉴찾기(간판이미지 업로드)" id="fileupload">
		<input type="button" class="btn pink darken-2" value="간판등록하기" id="enroll"><br>
		<div class="main_text z-depth-1 row" style="margin-left:auto; margin-right: auto;">
			<div class="col s6">
			<img src="resources/img/main.png" class="mainimg">
			<h3>Whame란?</h3>
			<p>Whame는 'What Menu'에서 비롯된 타이틀입니다. </p>
			<p>상가의 메뉴를 직접 들어가지 않고 밖에서 간판 사진을 이용하여 메뉴정보를 얻을 수 있습니다.</p>
			</div>
			<div class="col s6">
				<img src="resources/img/main_run.gif" class="mainrun">
			</div>
		</div>
		<div style="width:90%; margin-left: auto; margin-right: auto;" class="z-depth-1 row">
			<div class="main_mapform col s8">
				<div class="counter" data-count="00000${count}" id="test"></div>
				<div id="main_map"></div>
			</div>
			<div class="col s4">
				<h5>Top View</h5>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
	$(document).ready(function() {
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
	
		$("#enroll").on('click',function(){
			$(location).attr('href','enroll.whame');
		});

		var container = document.getElementById('main_map');
		var options = {
			center: new daum.maps.LatLng(37.50655,127.04964),
			level: 9
		};
		var map = new daum.maps.Map(container, options);

		var locationlist = ${locationlist};
		var max = locationlist.length / 3;
		var num = 0;
		for(var i =0; i<max; i++)
			{
				if(num <= locationlist.length)
					{
						 var marker = new daum.maps.Marker({
						        map: map, // 마커를 표시할 지도
						        position: new daum.maps.LatLng(locationlist[num+1],locationlist[num+2]), // 마커를 표시할 위치
						        title : locationlist[num] // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
						  });

						marker.setMap(map);
						num += 3;
					}
				else{
						break;
					}
			}
	})
</script>

