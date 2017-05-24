<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import ="spring.mvc.whame.history.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=37398369e1a52d60bd562e99b1d140aa&libraries=services"></script>
<div id="map" style="width:100%;height:350px;"></div>
<div style="width:50;height:50">
	<c:forEach items="${historylist}" var="vo" >
	<div id='${vo.store_code }'>
       <a href="historyInfo.whame?store_code=${vo.store_code }">
       	  <img src="http://s3-ap-northeast-1.amazonaws.com/whame01/StoreTitle/${vo.signimage }" style="width:30%; height:30%;">
       </a>
       <div class = 'code'> ${vo.store_code }</div>
       ${vo.h_date }<br>
       <div class='show'></div>
       ---------------------------------------------------------------------------------------------<br>
    </div>   
	</c:forEach> 
</div>        


<script src="resources/jquery-3.1.1.min.js"></script> 
<script type="text/javascript">
var x = ${latalon};
var length = ${length};
var position=[];
	for(var i=1; i<=length*2; i++){
		position[i] = x.slice(i-1,i);
	}
	
	var container = document.getElementById('map');
	var options = {
		center: new daum.maps.LatLng(37.49655,127.02964),
		level: 4
	};
	var map = new daum.maps.Map(container, options);
	for(var i=1; i<=length; i++){
		var marker = new daum.maps.Marker({
		    map: map,
		    position: new daum.maps.LatLng(position[(2*i)-1],position[i*2])
		});
	    // 마커에 표시할 인포윈도우를 생성합니다 
	    var infowindow = new daum.maps.InfoWindow({
	        content: "안뇽" // 인포윈도우에 표시할 내용
	    });
	    daum.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
	    daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
	}
	// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
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
	// 마커에 클릭이벤트를 등록합니다
	daum.maps.event.addListener(marker, 'click', function() {
	      // 마커 위에 인포윈도우를 표시합니다
	      infowindow.open(map, marker);  
	});
	
</script>