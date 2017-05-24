<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../modal/fileupload_modal.jsp" %>
<!-- Compiled and minified JavaScript -->
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

<script type="text/javascript">
	$(document).ready(function() {
		$("#fileupload").on('click',function(){
			$('#modal1').modal('open');
		});
	
		$("#enroll").on('click',function(){
			$(location).attr('href','enroll.whame');
		});
	})
</script>

