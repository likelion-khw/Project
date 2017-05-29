<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import ="spring.mvc.whame.history.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../modal/history_modal.jsp" %>  

<script	src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=f0f441314c4cc2b255e1663dc273009f&libraries=services"></script>


<div id="map" style="width:100%;height:350px;"></div>
<div style="width:50;height:50">
	<c:forEach items="${hMap}" var="vo" >
	<div class="slider">
    <ul class="slides">
		<c:forEach items="${vo.value }" var="his">
			<li>
		        <img src="http://s3-ap-northeast-1.amazonaws.com/whame01/StoreTitle/${his.signimage}" class="imagemodal" id='${his.store_code}'> <!-- random image -->
		        <div class="caption center-align">
		          <h3>${his.store_code}</h3>
		          <h5 class="light grey-text text-lighten-3">${his.h_date}</h5>
		        </div>
	      	</li>
		</c:forEach>
	</ul>
  	</div>
	</c:forEach> 
</div>  
      
      
<script type="text/javascript">
$(document).ready( function() {
	      $('.slider').slider();
	      
var x = ${latalon};
var length = ${length};
var positions=[];
	for(var i=0; i<length; i++){
	 positions[i] =  
	    {
	        content: x.slice(3*i,3*i+1), 
	        latlng: new daum.maps.LatLng(x.slice(3*i+1,3*i+2), x.slice(3*i+2,3*i+3))
	    };
	}
	
	var container = document.getElementById('map');
	var options = {
		center: new daum.maps.LatLng(37.49655,127.02964),
		level: 4
	};
	var map = new daum.maps.Map(container, options);
	
	for(var i=0; i<positions.length; i++){
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
		    var offset = $("#"+code).offset();
		      $('html,body').animate({scrollTop : offset.top}, 800);
	    console.log("#"+code);
		};
	}
	
	$("#fileupload").on('click',function(){
		$('#modal1').modal('open');
	});
	$("#enroll").on('click',function(){
		$(location).attr('href','enroll.whame');
	});
	
	$('.imagemodal').on('click',function(){ 
		var store_code = $(this).attr('id');
		console.log(store_code);
		$('#'+store_code+"modal").modal('open');
	}); 
	
	
}) 
</script>