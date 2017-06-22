<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../modal/fileupload_modal.jsp" %>
<%@include file="../modal/show_coupon_modal.jsp" %>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=
a6149740a5939346f553130276762c3d&libraries=services"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
<style>
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
	width:80%;
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
.showinfo_btn{
	margin-top:6%;
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
	<c:choose>
		<c:when test="${error != null}">
			<h3>${error}</h3>
		</c:when>
		<c:otherwise>
			<%-- <h5>사용자의 검색 정보</h5>
			<table class="centered bordered">
				<tbody>
					<tr>
						<td>ocr</td>
						<td><c:forEach items="${result }" var="vo">
					${vo.text }<br>
							</c:forEach></td>
					</tr>
					<tr>
						<td>color:</td>
						<td>R: ${color.red }<br> G: ${color.green }<br> B:
							${color.blue }<br>
						</td>
					</tr>
				</tbody>
			</table> --%>
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
		</c:otherwise>
	</c:choose>
</div>

<script type="text/javascript">
	$('ul.review div[name=blogs] dt').after('<p style=\"border:0.5px gray solid; margin-left:20%;margin-right:20%;margin-top:5px;margin-bottom:5px;\">');
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
$(document).ready(function() {
			$('.parallax').parallax();
	 		// 블로그 더보기 이벤트
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
				// 블로그 부분 접기 활성화 이벤트
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
				$("#coupon1").openModal();
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