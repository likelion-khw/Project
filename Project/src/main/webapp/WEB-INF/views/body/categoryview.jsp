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
	
}
	
}
</style>
<div class="container category_form center-align"> 
	<div class="search-class">
		<p>
			<input type="text" id="search-input" placeholder="메뉴를 입력해주세요" style="width:40%">
			<button id="search-button" class="btn">검색</button><br>
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

	<div class="row storeList"></div>
</div>
		

<script type="text/javascript">
$(document).ready(function(){
	$('a[class=menu_tag]').on('click',function(){
		$('.storeList').empty();
		
	var tagClick;
	
	if($(this).attr('id')=="tagChicken"){
		tagClick = "치킨";
	} 
	if($(this).attr('id')=="tagPizza"){
		tagClick = "피자";
	}
	
	if($(this).attr('id')=="tagPoke"){
		tagClick = "삼겹살";
	}
	
	if($(this).attr('id')=="tagChinese"){
		tagClick = "중국집";
	}
		
	if($(this).attr('id')=="tagSnackBar"){
		tagClick = "분식";
	} 
	if($(this).attr('id')=="tagBurger"){
		tagClick = "햄버거";
	}
	
	if($(this).attr('id')=="tagCafe"){
		tagClick = "카페";
	}
	
		$.ajax({
			url: "getTagStore.whame",
			type: "POST",
			data: {"tagClick" : tagClick},
			success: function(data){
				for(var index=0; index<data.length; index++){
					var storeList = $(
					        "<div class='col s12 m4' id='"+data[index].store_name+"'>"
					          +"<div class='card'>"
					            +"<div class='card-image'>"
					              +"<img src='resources/img/4.jpg'>"
					            +"</div>"
					            +"<div class='card-content'>"
					            	+"<p class='viewCount'> 조회수 - "+ data[index].view_count+"</p>"
				            		+"<div class='addr'>"+data[index].address+"</div>"
					            +"</div>"
					            +"<div class='card-action'>"
					              +"<a href='javascript:tag()' class='tagStore' id='"+data[index].store_code+"'>"+data[index].store_name+"</a>"
					            +"</div>"
					          +"</div>"
					        +"</div>"
					)
					$(".storeList").append(storeList);
			}
			}, error: function(){
				alert("태그 사용불가");
			}
		});
	});
	
	
	
	$(document).on('click','a[class=tagStore]',function(){
		
		var store_code = $(this).attr('id');
		console.log(store_code);
		$(location).attr("href", "forkakao.whame?store_code="+store_code);
	
	})
})
</script>