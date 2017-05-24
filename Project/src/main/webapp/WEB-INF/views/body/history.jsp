<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import ="spring.mvc.whame.history.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=37398369e1a52d60bd562e99b1d140aa&libraries=services"></script>
<div id="map" style="width:100%;height:350px;"></div>
<div style="width:50;height:50">
<div id="main">
	<c:forEach items="${historylist}" var="vo" >
		<section id="${vo.store_code }">
		<div id='${vo.store_code }'>
	      	<a href="historyInfo.whame?store_code=${vo.store_code }">
	       	  <img src="http://s3-ap-northeast-1.amazonaws.com/whame01/StoreTitle/${vo.signimage }" style="width:30%; height:30%;">
	       	</a>
	       	<div class = 'code'> ${vo.store_code }</div>
	      	 ${vo.h_date }<br>
	       	<div class='show'></div>
	       	---------------------------------------------------------------------------------------------<br>
    	</div>   
    	</section>
	</c:forEach> 
</div>
</div>        

<script src="resources/jquery-3.1.1.min.js"></script> 
<script type="text/javascript">
$(document).ready( function() {
var x = ${latalon};
var length = ${length};
var positions=[];
	for(var i=0; i<length; i++){
	 positions[i] =  
	    {
	        content: x.slice(3*i,3*i+1), 
	        latlng: new daum.maps.LatLng(x.slice(3*i+1,3*i+2), x.slice(3*i+2,3*i+3))
	    };
	 console.log(positions[i].content);
	 console.log(positions[i].latlng);
	}
	
	var container = document.getElementById('map');
	var options = {
		center: new daum.maps.LatLng(37.49655,127.02964),
		level: 4
	};
	var map = new daum.maps.Map(container, options);
	
	for(var i=0; i<positions.length; i++){
		console.log(i); 
		console.log("content"+positions[i].content);
	    var marker = new daum.maps.Marker({
		    map: map,
		    position: positions[i].latlng
		});
	    
	    var code = positions[i].content;
	    console.log(code);
	    
	    daum.maps.event.addListener(marker, 'click', movecard(code)); 
		
	}

	// 마커에 클릭이벤트를 등록합니다
	function movecard(code){
		return function() {
	    location.href = "#"+code;
	    console.log("#"+code);
		};
	}
	
})

</script>