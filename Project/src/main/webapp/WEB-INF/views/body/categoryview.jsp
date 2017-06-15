<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="spring.mvc.whame.store.*,java.util.*"%>
<%@include file="../modal/menu_modal.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
<style>
.card-content{
	height: 150px;
}
.category_form{
	margin-top:20px;
	padding:5px;
}

@media only screen and (min-width : 601px) and (max-width: 1000px) {
	.card-content{
		font-size: 16px;
	}
}

@media only screen and (min-width : 300px) and (max-width: 600px) {
	.card-content{
		font-size: 16px;
	}
	.card-content{
		height: 100px;
	}
}
</style>
<div class="container category_form center-align"> 
	<div class="search-class">
		<p>
			<div class="input">
				<input type="text" id="inputMenu" placeholder="메뉴를 입력해주세요" style="width:40%">
				<button id="searchButton" class="btn">검색</button><br>
			</div>
			<span id="tagMenu">
				<a href="javascript:ta" class="menu_tag" id="tagChicken">치킨</a>
				 |  <a href="javascript:ta" class="menu_tag" id="tagPizza">피자</a>
				 |  <a href="javascript:ta" class="menu_tag" id="tagPoke">삼겹살</a>
				 |  <a href="javascript:ta" class="menu_tag" id="tagChinese">중국집</a>
				 |  <a href="javascript:ta" class="menu_tag" id="tagSnackBar">분식</a>
				 |  <a href="javascript:ta" class="menu_tag" id="tagBurger">햄버거</a>
				 |  <a href="javascript:ta" class="menu_tag" id="tagCafe">카페</a>
			</span>
		</p>
	</div>

	<div class="count"></div>
	<div class="row storeList"></div>
</div>
		

<script type="text/javascript">

var storeName = [];
var storeCode = [];
var storeAddr = [];
var storeVC = [];

$(document).ready(function(){
	
	$('#searchButton').click(function(){
		
		var menuSearch = $("#inputMenu").val();
		
		var choice = "search";
		
	$('.storeList').empty();

		search(menuSearch, choice);
		
	});
})


$(document).ready(function(){
	
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


var search = function(menuSearch, choice){
	console.log("연결성공");
	$('.count').empty();
	$.ajax({
			url: "search.whame",
			type: "POST",
			data: {
				"menuSearch": menuSearch,
				"choice" : choice	
			},
			success: function(data){
				storeName = data["store_name"];
				storeCode = data["store_code"];
				storeAddr = data["address"];
				storeVC = data["view_count"];
				storeCount = data["count"];
				console.log(storeCount.length);

				$('.count').append("총 " + storeCount.length +"곳을 찾았습니다");
				
				for(var i = 0 ; i < storeName.length; i++){
				var storeList = $(
				        "<div class='col s12 m4' id='"+storeName[i].replace("\\(\\)","")+"'>"
				          +"<div class='card'>"
				            +"<div class='card-image'>"
				              +"<img src='resources/img/4.jpg'>"
				            +"</div>"
				            +"<div class='card-content'>"
				            	+"<p class='viewcount'> 조회수 - "+ storeVC[i]+"</p>"
			            		+"<div class='address'>"+storeAddr[i]+"</div>"
				            +"</div>"
				            +"<div class='card-action'>"
				              +"<a href='javascript:tag()' class='tagStore' id='"+storeCode[i]+"'>"+storeName[i].replace("\\(\\)","")+"</a>"
				            +"</div>"
				          +"</div>"
				        +"</div>"
				)
					$(".storeList").append(storeList);
				}
				
				$('.tagStore').css('font-size','0.85rem');
				$('.viewcount').css('font-size','0.9rem');
				$('.address').css('font-size','0.9rem');
			}, error: function(){
				alert("다시한번 검색하십시오");
		}
	});
}
</script>