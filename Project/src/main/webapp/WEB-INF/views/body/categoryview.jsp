<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="spring.mvc.whame.store.*,java.util.*"%>
<%@include file="../modal/menu_modal.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
<style>
.search-class {
	height: 40px;
	width: 400px;
	border: 0px;
	text-align: center;
	} 
.search-input {
	font-size: 16px;
	width: 325px;
	padding: 10px;
	border: 0px;
	outline: none;
	float: left;
}	
.search-button {
	width: 50px;
	height: 100%;
	border:0px;
	background: #1b5ac2;
	outline: none;
	float: right;
	color: #ffffff;
}

.card-image{
	width: 300px;
	heigth: 300px;
}

img{
	width: 100%;
	height: 100%;
}

.storeList{
	position: relative;
	bottom: -100px;
}
</style>

	<div class="search-class">
		<p>
			<input type="text" id="search-input" placeholder="업소명을 입력해주세요">
			<span id="tagMenu">
				<a href="javascript:ta" id="tagChicken" class="menu_tag">치킨</a>
				 |  <a href="javascript:ta" id="tagPizza" class="menu_tag">피자</a>
				 |  <a href="javascript:ta" id="tagPoke" class="menu_tag">삼겹살</a>
				 |  <a href="javascript:ta" id="tagChinese" class="menu_tag">중국집</a>
				 |  <a href="javascript:ta" id="tagSnackBar" class="menu_tag">분식</a>
				 |  <a href="javascript:ta" id="tagBurger" class="menu_tag">햄버거</a>
				 |  <a href="javascript:ta" id="tagCafe" class="menu_tag">카페</a>
			</span>
			<button id="search-button">검색</button>
		</p>
	</div>
	
 
      <div class="storeList">
      
      </div>

	
<script type="text/javascript">

// 태그 메뉴정보 출력
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

				var storeList=$(
						  "<div class="+"row"+">"
					        +"<div class="+"col s12 m7"+">"
					          +"<div class="+"card"+">"
					            +"<div class="+"card-image"+">"
					              +"<img src="+"images/sample-1.jpg"+">"
					              +"<span class="+"card-title"+">"+data[index]+"</span>"
					            +"</div>"
					            +"<div class="+"card-content"+">"
					              +"<p value="+"tag"+">I am a very simple card. I am good at containing small bits of information."
					              +"I am convenient because I require little markup to use effectively.</p>"
					            +"</div>"
					            +"<div class="+"card-action"+">"
					              +"<a href="+"#+"+">"+data[index]+"</a>"
					            +"</div>"
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
})
</script>

	
