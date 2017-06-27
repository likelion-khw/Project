<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import ="spring.mvc.whame.history.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../modal/history_modal.jsp" %>  
<%@include file="../modal/fileupload_modal.jsp" %>
<%@include file="../modal/infomodal.jsp" %>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=
03947296fa39c02cca384bf32800c263&libraries=services"></script>
<style>
	.history_form{
		margin-top:20px;
		margin-bottom:20px;
		width: 80%;
		padding:20px;
		border-radius:30px;
	}
	.history_form .h_map{
		margin-bottom:20px;
	}
	.indicators{
		visibility:hidden;
	}
	.history_form .sli{
		margin-left:auto;
		margin-right: auto;
	}
	.caption{
		background: #ffffff;
		background: rgba(255,255,255,0.5);
	}
	.h_map{
		width:100%;
		height:350px;
	}
	.his_no{
		height:450px;
		padding-top:15%;
	}
	
	@media only screen and (min-width : 320px) and (max-width : 600px) {
	
		.slider{
			width:112%;
		}
		
		.history_form .sli{
		margin-left: 0;
		margin-right: 0;
		}
		
		.h_map{
			height: 250px;
		}
		
		.slides .listsize{
			height: 200px;
		}
	}
	
	@media only screen and (min-height : 636px) {
		.his_no{
			height:570px;
		}
	}
	
</style>

<script>
 function his_new(){
	 $('#modal1').modal('open');
 }
</script>
<div class="container history_form z-depth-2">
	<c:choose>
		<c:when test="${historylist != '[]'}">
			<div id="map" class="h_map"></div>
			<div class = 'row'>
				<input type="date" class="datepicker col s5" name="s_date" id="s_date">
				<input type="date" class="datepicker col s5" name="e_date" id="e_date">
				<input type="button" class= "btn green" value="조회" id="sort">
			</div>
			<div style="width:90%;" class="sli">
				<c:forEach items="${hMap}" var="vo" >
				<div class="slider z-depth-3" style="margin-bottom:30px;">
			    <ul class="slides">
					<c:forEach items="${vo.value }" var="his">
						<li class='listsize' style="heigth:200px;">
					        <img src="http://s3-ap-northeast-1.amazonaws.com/whame/StoreTitle/${his.signimage}" class="imagemodal" id='${his.store_code}'> <!-- random image -->
					        <div class="caption center-align">
					          	<c:forEach items="${storelist }" var="comstore">
			 				        <c:set value="${comstore.store_code }" var="scode"/>
			 						<c:set value="${his.store_code}" var="hcode"/>
			 			        	<c:if test="${scode == hcode }">
			 			   	       <h3 class="grey-text text-darken-4">${comstore.store_name}</h3>			        
			 			   	     	</c:if>
			 		 		       </c:forEach>
		 			          <h5 class="light grey-text text-darken-2">
		 			          <fmt:formatDate type="both" dateStyle="short" timeStyle = "short" value="${his.h_date}"/>
		 			          </h5>
					        </div>
				      	</li>
					</c:forEach>
				</ul>
				<div class="center-align" style="margin-top:4px;">
					<a href="javascript:"><i class="material-icons small" style="margin-right:30%;" id="left">keyboard_arrow_left</i></a>
					<a href="javascript:"><i class="material-icons small del_his" style="margin-right:30%;"><span style="color:red">close</span></i></a>
					<a href="javascript:"><i class="material-icons small" id="right">keyboard_arrow_right</i></a>
				</div>
			  	</div>
				</c:forEach>
			</div>
			<div class="fixed-action-btn horizontal">
			    <a class="btn-floating btn-large white" id="upview" href="#top_view">
			      <i class="material-icons" style="color:black">arrow_upward</i>
			    </a>
			 </div> 
		</c:when>
		<c:otherwise>
			<div class="his_no center-align">
				<h3 style="width: 100%;">히스토리 정보가 없습니다.</h3>
				<h5 style="width: 100%">히스토리를 추가하러 가볼까요?</h5>
				<input type="button" class="btn green" value="메뉴찾기" onclick="his_new();" style="border-radius:30px; margin-top:20px;"><br>
			</div>
		</c:otherwise>
	</c:choose>
</div>
      
<script type="text/javascript">
$(document).ready( function() {
	$('.slider').slider();

	$('i#left').on('click',function(){
		$(this).parent().parent().slider('prev');
	});

	$('i#right').on('click',function(){
		$(this).parent().parent().slider('next');
	});
	      
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
		center: new daum.maps.LatLng(x.slice(3*(length-1)+1,3*(length-1)+2),x.slice(3*(length-1)+2,3*(length-1)+3)),
		level: 7
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

	$('.del_his').on('click',function(){
		var store_code = $(this).parent().parent().parent().children().children().children().attr('id');
		var userid = '${memberVO.userid}';
		$('#history_del').modal('open');
		$('#info_his_del').on('click',function(){
			$.ajax({
				url: 'removeHistory.whame',
				type: 'post',
				data : { 'store_code' : store_code ,
						 'userid' : userid
					},
				success : function(result){
					$(location).attr('href','history.whame');
				}
			
			})
		});
	});
	
	$('.imagemodal').on('click',function(){ 
		var store_code = $(this).attr('id');
		console.log(store_code);
		$('#'+store_code+"modal").modal('open');
	}); 

	$("#upview").click(function(event){            
	    event.preventDefault();
	    $('html,body').animate({scrollTop:$(this.hash).offset().top+1}, 500);
	});
	
	$('.datepicker').pickadate({
		selectMonths: true, // Creates a dropdown to control month
		selectYears: 15, // Creates a dropdown of 15 years to control year
		format: 'yyyy-mm-dd',
		labelMonthNext: '이전 달',
		labelMonthPrev: '다음 달',
		monthsFull: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		monthsShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		weekdaysFull: ['일', '월', '화', '수', '목', '금', '토'],
		weekdaysShort: ['일', '월', '화', '수', '목', '금', '토'],
		weekdaysLetter: ['일', '월', '화', '수', '목', '금', '토'],
		max: new Date(),
		today: 'Today',
		clear: 'Clear',
		close: 'Close'
		});
	$('#sort').on('click', function(){
		var s_date = $('#s_date').val();
		var e_date = $('#e_date').val();
		console.log("시작일과 종료일 조회:::"+s_date +":::"+e_date);
		$('.sli').html('<c:forEach items="${hMap}" var="vo" >'
				+'<div class="slider z-depth-3" style="margin-bottom:30px;">'
				+' <ul class="slides">'
				+'<c:forEach items="${vo.value }" var="his">'
				+'<li class="listsize" style="heigth:200px;">'
				+' <img src="http://s3-ap-northeast-1.amazonaws.com/whame/StoreTitle/${his.signimage}" class="imagemodal" id="${his.store_code}"> '
				+' <div class="caption center-align">'
				+'<c:forEach items="${storelist }" var="comstore">'
				+'  <c:set value="${comstore.store_code }" var="scode"/>'
				+'<c:set value="${his.store_code}" var="hcode"/>'
				+'<c:if test="${scode == hcode }">'
				+' <h3 class="grey-text text-darken-4">${comstore.store_name}</h3>	'		        
				+'	</c:if>'
				+'   </c:forEach>'
				+' <h5 class="light grey-text text-darken-2">${his.h_date}</h5>'
				+' </div>'
				+' </li>'
				+' </c:forEach>'
				+' </ul>'
				+' <div class="center-align" style="margin-top:4px;">'
				+' <a href="javascript:"><i class="material-icons small" style="margin-right:30%;" id="left">keyboard_arrow_left</i></a>'
				+' <a href="javascript:"><i class="material-icons small del_his" style="margin-right:30%;"><span style="color:red">close</span></i></a>'
				+' <a href="javascript:"><i class="material-icons small" id="right">keyboard_arrow_right</i></a>'
				+' </div>'
				+' </div>'
				+' </c:forEach> ');
	});
}) 
</script>