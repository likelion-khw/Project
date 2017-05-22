<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- Compiled and minified JavaScript -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
<style type="text/css">
.mainform{
	margin-top: 20px;
}
</style>
<div class="container mainform">
	<div class="center-align">
		<input type="button" class="btn" value="메뉴찾기(간판이미지 업로드)" id="fileupload">
		<input type="button" class="btn" value="간판등록하기" id="enroll"><br>
	</div>
</div>

<img src="https://s3-ap-northeast-1.amazonaws.com/whame01/StoreTitle/38979b2b4ebd4d3098cf16185eb66e6f.jpg" style="max-width:1024px; max-height:800px; width:100%; height:100%;">
<jsp:include page="../modal/fileupload_modal.jsp"/>

<script type="text/javascript">
	$(document).ready(function() {
		$("#fileupload").on('click',function(){
			$('#modal1').modal('open');
		});
	
		$("#enroll").on('click',function(){
			$(location).attr('href','enroll.whame');
		});

		$('.modal').modal();
	})
</script>

