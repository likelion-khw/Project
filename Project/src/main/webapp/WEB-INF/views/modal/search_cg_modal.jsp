<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <!-- JS file -->
<script src="resources/js/jquery.easy-autocomplete.min.js"></script> 
<!-- CSS file -->
<link rel="stylesheet" href="resources/css/easy-autocomplete.min.css"> 

<!-- Additional CSS Themes file - not required-->
<link rel="stylesheet" href="resources/css/easy-autocomplete.themes.min.css"> 

<style>
.category_form{
	padding:10%;
}
</style>

<script type="text/javascript">
function enterkey2() {
    if (window.event.keyCode == 13) {
	    	$('#searchbutton').trigger('click');
    }
}
</script>
<div id="search_cg" class="side-nav search_cg">
	<a href="#!"><i class="material-icons" id="search_close" style="margin-top:20px; margin-left:20px; color:black">close</i></a>
	<div class="category_form center-align"> 
		<div class="search-class" id="top_search">
				<label>반경설정</label>
				<select class="browser-default" style="width:100px;margin-left:auto;margin-right:auto" id="meter">
				    <option value="300" selected="selected">300m</option>
				    <option value="500">500m</option>
				    <option value="800">800m</option>
				    <option value="1000">1000m</option>
				</select>
		          <label for="inputMenu">메뉴를 입력해주세요.</label>
				  <input type="text" id="inputMenu" class="validate" style="border:1px #e0e0e0 solid" onkeyup="enterkey2()">
				<div class="input">
					<button id="searchbutton" class="btn">검색</button><br>
				</div>
			</p>
		</div>
		<div id='lal'></div>
		<div class="count" style="font-size:12px"></div>
		<div class="row storeList" id="staggered-test">
		</div>
	</div>
</div>	
<script type="text/javascript">
var storeName = [];
var storeCode = [];
var storeAddr = [];
var storeVC = [];
$(document).ready(function(){
	
	navigator.geolocation.getCurrentPosition(showPosition,showError);
	
	$('#searchbutton').click(function(){
		var menuSearch = $("#inputMenu").val();
		var choice = "search";
		$('.storeList').empty();
		search(menuSearch, choice);

	});

	var Menudata = new Array();
	<c:forEach items="${getMenuAuto}" var="menu">
		Menudata.push(('${menu}'));
	</c:forEach>
	var options = {
			data: Menudata,
			list: {
				maxNumberOfElements: 6,
				match: {
					enabled: true
				}
			}
		};

		$("#inputMenu").easyAutocomplete(options);
	
	/* $('a[class=menu_tag]').on('click',function(){
		$('.storeList').empty();
		
		var menuSearch;
		
		if($(this).attr('id')=="tagChicken"){
			menuSearch = "치킨";
		} 
		
		if($(this).attr('id')=="tagPizza"){
			menuSearch = "피자";
		}
		
		if($(this).attr('id')=="tagPoke"){
			menuSearch = "삼겹살";
		}
		
		if($(this).attr('id')=="tagChinese"){
			menuSearch = "중국집";
		}
			
		if($(this).attr('id')=="tagSnackBar"){
			menuSearch = "분식";
		} 
		if($(this).attr('id')=="tagBurger"){
			menuSearch = "햄버거";
		}
		
		if($(this).attr('id')=="tagCafe"){
			menuSearch = "카페";
		}
		
		var choice = "tag";
			search(menuSearch, choice);
		}); */
		
		
	})
	
	$(document).on('click','a[class=tagStore]',function(){
		var store_code = $(this).attr('id');
		console.log(store_code);
			
		$(location).attr("href", "forkakao.whame?store_code="+store_code);
		
	})
	
	$(document).on('click','span#test_sc',function(event){
		$('#inputMenu').focus();
	});
	
	function showPosition(position) {
			$.when( 
				lat = position.coords.latitude,
				lng = position.coords.longitude
			).then(function(){
				document.getElementById("lal").innerHTML += "<input type=hidden name=lat id='lat' value=" + lat+ ">"
				+"<input type=hidden id='lon' name=lon value=" + lng + ">";
			});
			console.log("===="+lat+":::"+lng);
			}
		
		function showError(error)
		{
			var no_text;
			lat = 37.520498;
			lng = 127.022959;
			document.getElementById("lal").innerHTML += "<input type=hidden name=lat id='lat' value=" + lat+ ">"
			+"<input type=hidden id='lon' name=lon value=" + lng + ">";
		}
		
	var search = function(menuSearch, choice){
		var lat;
		var lng;
		
		
		var clat = $('#lat').val();
		var clon = $('#lon').val();
		
		console.log("연결성공");
		$('.count').empty();
		$.ajax({
				url: "search.whame",
				type: "POST",
				data: {
					"menuSearch": menuSearch,
					"choice" : choice,	
					"clat" : clat,
					"clon" : clon,
					"meter" : $('#meter').val()
				},
				success: function(data){
					console.log(data.length);
					$('.count').append("총 " + data.length +"곳을 찾았습니다");
					
					for(var i = 0 ; i < data.length; i++){
						 var walkkTime = parseInt(data[i].meter) / 67 | 0;
						    var walkHour = '', walkMin = '';

						    // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
						    if (walkkTime > 60) {
						        walkHour = '<span class="number" style="color:red">' + Math.floor(walkkTime / 60) + '</span>시간 ';
						    }
						  if((walkkTime % 60) < 1)
							  {
								  walkMin = '<span class="number" style="color:red">' + 1 + '</span>분';
							  }else{
						 		 walkMin = '<span class="number" style="color:red">' + walkkTime % 60 + '</span>분';
							  }
						  
						var storeList = $(
						        "<div class='col s12' id='"+data[i].store_name+"' style='border-radius:50px;'>"
						          +"<div class='card'>"
						            +"<div class='card-image'>"
						              +"<img src='"+data[i].store_image+"' width='100%' height='200px;'>"
						            +"</div>"
						            +"<div class='card-content'>"
						            	+"<p class='viewcount'> 거리 : 약 <span style='color:red'>"+ parseInt(data[i].meter)+"</span>m</p><br>"
						            	+"<p> 도보 : "+walkHour+walkMin+"</p><br>"
					            		+"<div class='address'>"+data[i].address+"</div>"
						            +"</div>"
						            +"<div class='card-action'>"
						              +"<a href='javascript:tag()' class='tagStore' id='"+data[i].store_code+"' style='margin-right:0px'>"+data[i].store_name+"</a><br>"
						              +"<span style='border-radius:30px; text-align:center' class='btn white' id='test_sc'>"
					          	      	+"<i class='material-icons' style='color:black'>arrow_drop_up</i>"
					          	     	+"</span>"
						            +"</div>"
						          +"</div>"
						        +"</div>"
						)
						$(".storeList").append(storeList);
					}
					$('.tagStore').css('font-size','14px');
				}, error: function(){
					alert("다시한번 검색하십시오");
			}
		});
	}
</script>
