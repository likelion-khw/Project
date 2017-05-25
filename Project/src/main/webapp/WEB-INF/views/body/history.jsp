<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import ="spring.mvc.whame.history.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../modal/history_modal.jsp" %>  

<script	src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=37398369e1a52d60bd562e99b1d140aa&libraries=services"></script>
<% 
	List<HistoryVO> hlist = (List<HistoryVO>)request.getAttribute("historylist");
	HashMap<Integer, Integer> iscode = new HashMap<Integer,Integer>();
 	for(HistoryVO vo : hlist){
		iscode.put(vo.getStore_code(), 0);
	} 
	int i = 0;
	int j = 0;
	String[] move = {"one!", "two!", "three!", "four!"};
%>
<div id="map" style="width:100%;height:350px;"></div>
<div style="width:50;height:50">
<div id="main">
	<c:forEach items="${historylist}" var="vo" >
<% 
	int hcode = hlist.get(i).getStore_code();
	 if(iscode.get(hlist.get(i).getStore_code())==0 ) {
		 System.out.println("들어옴");
		iscode.put(hlist.get(i++).getStore_code(),1); 
%>
		<div class="carousel carousel-slider center" data-indicators="true">
		    <div class="carousel-fixed-item center">
		    </div>
		    <div class="carousel-item red white-text" href="#one! %>">
		      	<div id='${vo.store_code }'>
					<img class="image" src="http://s3-ap-northeast-1.amazonaws.com/whame01/StoreTitle/${vo.signimage }" style="width:60%; height:60%;">
		       		<div class = 'code'> ${vo.store_code }</div>
		      		 ${vo.h_date }<br>
		       		<div class='show'></div>
    			</div> 
	    	</div>
		     <div id ='${vo.store_code }row'></div>
		 </div>
<%
	 }else{
%>		
		<%-- <input type="text" id="${vo.store_code }_tos"  onclick ="loadImage(${vo.store_code })" name="${vo.signimage }"> --%>
<%	}
%>

	</c:forEach> 
</div>
</div>  
      
<!-- <script src="resources/js/jquery-3.1.1.min.js"></script> -->
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
	    location.href = "#"+code;
	    console.log("#"+code);
		};
	}
	
	$("#fileupload").on('click',function(){
		$('#modal1').modal('open');
	});

	$("#enroll").on('click',function(){
		$(location).attr('href','enroll.whame');
	});
	
	$('.image').on('click',function(){ 
		var store_code = $(this).parent().attr('id');
		console.log(store_code);
		$('#'+store_code+"modal").modal('open');
	}); 
	
	$('.carousel.carousel-slider').carousel({fullWidth: true});
	
}) 




</script>