<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
			alert("test");
				$(location).attr('href','fileupload.whame');
		});

		$("#enroll").on('click',function(){
			$(location).attr('href','enroll.whame');
	});
	})
</script>
