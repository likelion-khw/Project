<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.category_form{
	margin-top:20px;
	padding:10%;
}
</style>
<div id="search_cg" class="side-nav search_cg">
	<a href="#!"><i class="material-icons" id="search_close" style="margin-top:20px; margin-left:20px; color:black">close</i></a>
	<div class="category_form center-align"> 
		<div class="search-class" id="top_search">
				<div class="input-field">
				  <i class="material-icons prefix">search</i>
				  <input type="text" id="inputMenu" class="validate" style="width:80%" onkeyup="enterkey2()">
		          <label for="inputMenu">메뉴를 입력해주세요.</label>
		        </div>
				<div class="input">
					<button id="searchbutton" class="btn">검색</button><br>
				</div>
				<!-- <span id="tagMenu">
					<a href="javascript:ta" class="menu_tag" id="tagChicken">치킨</a>
					 |  <a href="javascript:ta" class="menu_tag" id="tagPizza">피자</a>
					 |  <a href="javascript:ta" class="menu_tag" id="tagPoke">삼겹살</a>
					 |  <a href="javascript:ta" class="menu_tag" id="tagChinese">중국집</a>
					 |  <a href="javascript:ta" class="menu_tag" id="tagSnackBar">분식</a>
					 |  <a href="javascript:ta" class="menu_tag" id="tagBurger">햄버거</a>
					 |  <a href="javascript:ta" class="menu_tag" id="tagCafe">카페</a>
				</span> -->
			</p>
		</div>
		<div id='lal'></div>
		<div class="count"></div>
		<div class="row storeList"></div>
	</div>
</div>	
<script type="text/javascript">
var storeName = [];
var storeCode = [];
var storeAddr = [];
var storeVC = [];
function enterkey2() {
    if (window.event.keyCode == 13) {
    	$('#searchbutton').trigger('click'); 
    }
}

$(document).ready(function(){
	
	navigator.geolocation.getCurrentPosition(showPosition,showError);
	
	$('#searchbutton').click(function(){
		var menuSearch = $("#inputMenu").val();
		var choice = "search";
		$('.storeList').empty();
		search(menuSearch, choice);
		
	});
	
	$('a[class=menu_tag]').on('click',function(){
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
		});
		

		
		
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
					"clon" : clon
				},
				success: function(data){
					console.log(data.length);
					$('.count').append("총 " + data.length +"곳을 찾았습니다");
					
					for(var i = 0 ; i < data.length; i++){
						var storeList = $(
						        "<div class='col s12' id='"+data[i].store_name.replace("\\(\\)","")+"'>"
						          +"<div class='card'>"
						            +"<div class='card-image'>"
						              +"<img src='"+data[i].store_image+"' width='100%' height='200px;'>"
						            +"</div>"
						            +"<div class='card-content'>"
							            +"<span style='float:right; border-radius:30px; text-align:center' class='btn white' id='test_sc'>"
					          	      	+"<i class='material-icons' style='color:black'>arrow_drop_up</i>"
					          	      +"</span>"
						            	+"<p class='viewcount'> 조회수 - "+ data[i].view_count+"</p><br>"
					            		+"<div class='address'>"+data[i].address+"</div>"
						            +"</div>"
						            +"<div class='card-action'>"
						              +"<a href='javascript:tag()' class='tagStore' id='"+data[i].store_code+"'>"+data[i].store_name.replace("\\(\\)","")+"</a>"
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
