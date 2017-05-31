<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../modal/fileupload_modal.jsp" %>
<!-- Compiled and minified JavaScript -->

<style type="text/css">
.mainform{
	margin-top: 20px;
	padding-top: 20px;
	padding-bottom: 20px;
	width: 90%;
	}
.counter{
	margin-bottom:20px;
}
.mainimg{
	width:30%;
}
.main_text{
	padding:20px; width:70%; margin-left:auto; margin-right: auto;
	background-color: #f5f5f5;
}

@media only screen and (min-width : 321px) and (max-width : 600px) {
	.mainimg{
	width:50%;
	}
	.main_text p{
		font-size:16px;
	}
	.mainform input{
		margin-bottom:10px;
	}
	.main_text{
		width:90%;
	}
}
</style>

<div class="container mainform z-depth-3">
	<div class="center-align" style="padding:10px">
		<input type="button" class="btn green" value="메뉴찾기(간판이미지 업로드)" id="fileupload">
		<input type="button" class="btn pink darken-2" value="간판등록하기" id="enroll"><br>
		<h4>Store Count</h4>
		<h2 id="counter"></h2>
		<div class="counter" data-count="" id="test"></div>
		<div class="main_text z-depth-1">
			<img src="resources/img/main.png" class="mainimg">
			<h3>Whame란?</h3>
			<p>Whame는 'What Menu'에서 비롯된 타이틀입니다. </p>
			<p>상가의 메뉴를 직접 들어가지 않고 밖에서 간판 사진을 이용하여 메뉴정보를 얻을 수 있습니다.</p>
		</div>
	</div>
</div>


<script type="text/javascript">
	$(document).ready(function() {
		$("#fileupload").on('click',function(){
			$('#modal1').modal('open');
		});
	
		$("#enroll").on('click',function(){
			$(location).attr('href','enroll.whame');
		});

		    
		 $.ajax({
			 	url : 'storeCount.whame',
			 	type : 'post',
			 	success : function(result){
			 			$('#test').attr('data-count',"000000"+result);
			 			 $(".counter").rollingCounter({
			 		        animate : true,
			 		        attrCount : 'data-count',
			 		        delayTime : 30 ,
			 		        waitTime : 1 ,
			 		        easing : 'easeOutBounce',
			 		        duration : 1000
			 		    });
			 		    
				 	}
			 });

	})
</script>

