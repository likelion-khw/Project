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
</style>
<div class="container mainform z-depth-3">
	<div class="center-align ">
		<input type="button" class="btn" value="메뉴찾기(간판이미지 업로드)" id="fileupload">
		<input type="button" class="btn" value="간판등록하기" id="enroll"><br>
		<h4>Store Count</h4>
		<h2 id="counter"></h2>
		<div class="counter" data-count="" id="test"></div>
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
			 })
		    
		   

	})
</script>

