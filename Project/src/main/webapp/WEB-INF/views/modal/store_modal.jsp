<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="spring.mvc.whame.store.*, spring.mvc.whame.region.*, java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
<style>
</style>
<div class="container center-align">
 	<c:forEach items="${storeMap }" var="svo">
	 	<div class='locCode' style="display: none;">${svo.value.store_code } </div> 
		 	<div id="${svo.value.store_code }modal_store" class="modal">
		 	 <div class="modal-content" id='${svo.value.store_code }'> 
				<h4>${svo.value.store_name }</h4>
				<table class="centered" style="margin-bottom:20px;" id='uptable'>
					<tr>
						<th>사업자번호</th>
						<td><input type="text" id="${svo.value.store_code }bus" name="business_code" value="${svo.value.business_code }"></td>
					</tr>
					<tr>
						<th>사업자id</th>
						<td><input type="text"  id="${svo.value.store_code }user" name="userid" value="${svo.value.userid}"></td>
					</tr>
					<tr>
						<th>상호명</th>
						<td><input type="text"  id="${svo.value.store_code }name" name="store_name" value="${svo.value.store_name }"></td>
					</tr>
					<tr>
						<th>영업시간</th>
						<td><input type="text"  id="${svo.value.store_code }time" name="operating_time" value="${svo.value.operating_time }"></td>
					</tr>
					<tr>
					<c:forEach var="lvo" items="${loclist }">
						<c:if test="${lvo.key == svo.value.store_code}">
						<c:set var="lval" value="${lvo.value }"/>
							<th>상가 위치</th>
							<td><div id='${svo.value.store_code }sa'>
								<input type="text" class="postcodify_extra_info col s6"  value="${lval.dong}" placeholder="동"/>
								<input type="text" id="${svo.value.store_code }loc" name="address" class="postcodify_address col s12" value="${lval.address }" placeholder="시/군/구"/>
								<input type="button" value="검색" class="btn blue floting postcodify_search_button${svo.value.store_code }" style="float:none;">
							</div></td>
						</c:if>
					</c:forEach>
					</tr>
				</table>
				<input type="hidden" value="${svo.value.store_code }" name="store_code">
				<input type="hidden" value="${svo.value.view_count }" name="view_count">
				
				<div class="modal-footer" >
					<input type="button" value="변경" id='storeupdate' class="modal-action modal-close btn blue floting" onclick='submit(${svo.value.store_code })' style="float:none;">
					<input type="button"  value="상가삭제" class="modal-action btn red floting" style="float:none;">
					<a href="#!" class="modal-action modal-close btn green floting" style="float:none;">닫기</a>
	 			</div>
			</div> 
	 		</div>
 		</c:forEach>
</div>


<script type="text/javascript">
/* $(function() {$(".postcodify_search_button").postcodifyPopUp({  
	 container: $("#1121") 
	});
	
}) */
function submit(store_code){
 	var s = store_code;	//code:business;userid;name;operating
 	var sm_address =$('#'+s+"loc").val();
 	var lat,lon;
 			
 	// 주소-좌표 변환 객체를 생성합니다
 	var geocoder = new daum.maps.services.Geocoder();
 	// 주소로 좌표를 검색합니다
 	geocoder.addr2coord(sm_address, function(status, result) {
 	// 정상적으로 검색이 완료됐으면 
 	if (status === daum.maps.services.Status.OK) {
 		lat = (result.addr[0].lat).toFixed(6);
 		lon = (result.addr[0].lng).toFixed(6);
 					
		var sm_business_code = $('#'+s+"bus").val();
		var sm_userid = $('#'+s+"user").val();
		var sm_store_name =$('#'+s+"name").val();
		var sm_operating_time =$('#'+s+"time").val();
		 			
 	    alert(lat+","+ lon);
		$.ajax({
		 	url : 'storeUpdate.whame',
		 	type: 'post',
		 	data : {
		 		'store_code' : s,
		 		'business_code' : sm_business_code,
		 		'userid' : sm_userid,
		 		'store_name' : sm_store_name,
		 		'operating_time' : sm_operating_time,
		 		'address' : sm_address,
		 		'lat' : lat,
		 		'lon' : lon
		 	},
		 	success : function(){
		 		alert('수정완료!');
		 		location.href = "store.whame";
		 	}
		});  
 	  }
 	            
 	 });
 	                
	} 
 		
 	$(document).ready(function(){
 		var locstore = $('.locCode').text();
 		var locstorecode = locstore.split(" ");
 		for(i=0; i<locstorecode.length-1; i++){
	 		$(".postcodify_search_button"+locstorecode[i]).postcodifyPopUp({  
	 			 container: $("#"+locstorecode[i]+"sa") 
	 			});
 			
 		}
 		
		$('input[value=상가삭제]').on('click',function(){
			$('#store_del').modal('open');
			var store_code = $(this).parent().parent().attr('id');

			$('#info_store_del').on('click',function(){
				$.ajax({
					url : 'deleteStore.whame',
					type : 'post',
					data : {
						'store_code' : store_code
					},
					success : function(result){
						if(result == 1)
							{
								$(location).attr('href','store.whame');
							}
					}
				});
			})
		});
 		
 	 });
 	
 		function c(code){
 			console.log(code);
 			var coupon_contents = $('#'+code+'con').val();
 			var coupon_s_time = $('#'+code+"s_time").val();
 			var coupon_e_time = $('#'+code+"e_time").val();
 			console.log(coupon_contents);
			console.log(coupon_s_time);
			
			$.ajax({
					url : 'couponInsert.whame',
					type: 'post',
					data : {
							'store_code' : code,
							'contents' : coupon_contents,
							's_time' : coupon_s_time,
							'e_time' : coupon_e_time
						},
					success : function(){
							alert('등록완료!');
						}
				}); 
 		}
 		
 		function startdate(t){
 			var startdate = t.val();
 			var perstart = startdate.split('-');
 			var now = new Date();
 			var instart = new Date(perstart[0],perstart[1]-1,perstart[2]);
 			
 			if( now.getTime() > instart.getTime()){
 				alert("현재날짜 이후로 입력해 주세요.");
 				
 			}
 		}
 		
 		
 		
 	
 </script>