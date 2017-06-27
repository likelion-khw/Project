<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, height=device-height">
<script type="text/javascript" src="resources/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-rollingCounter.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-easing.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<link rel="stylesheet" href="resources/css/countstyle.css" type="text/css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/css/materialize.min.css">
<!-- Compiled and minified JavaScript -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">


<style type="text/css">
header, main, footer {
	padding-left: 240px;
}
 @import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css);
.geo_text{
	font-family: 'Nanum Pen Script';
	font-size:36px;
	font:bold;
}
.geo_loding{
	padding-left: 240px;
	position: fixed;
	width:100%;
	top:25%;
}

.img_loding{
	padding-left: 240px;
	position: fixed;
	width:100%;
	top:25%;
}

@media only screen and (max-width : 992px) {
	header, main, footer, .geo_loding, .img_loding {
		padding-left: 0;
	}
	
	
}

@media only screen and (min-width : 300px) and (max-width:700px) {
	.geo_loding img, .img_loding img{
		width:40%;
	}
}


main{
	min-height: 520px;
}

</style>

<title><tiles:getAsString name="title"></tiles:getAsString></title>
</head>
<body>
	<header> <tiles:insertAttribute name="header" /> </header>
	<div class="row" style="margin-bottom:0px;">
		<tiles:insertAttribute name="sidebar" />
		<main> <tiles:insertAttribute name="body" /> </main>
		<div class="col-md-12">
			<tiles:insertAttribute name="footer" />
		</div>
	</div>
	
	<div class="geo_loding center-align" style="display:none;">
		<img src="resources/img/loding.gif">
		<h5 class="geo_text">사용자 위치정보 로딩중..</h5>
	</div>
	<div class="img_loding center-align" style="display:none;">
		<img src="resources/img/loding.gif">
		<h5 class="geo_text">데이터 로딩중..</h5>
	</div>
</body>

<script type="text/javascript">
	$(document).ready(function() {
		 $('.modal').modal({
		      dismissible: true, // Modal can be dismissed by clicking outside of the modal
		      opacity: .5, // Opacity of modal background
		      inDuration: 200, // Transition in duration
		      outDuration: 200, // Transition out duration
		      startingTop: '4%', // Starting top style attribute
		      endingTop: '5%' // Ending top style attribute
		    }
		  );

		$('#search_close').on('click',function(){
	   	 	$('.button-collapse.search_cg').sideNav('hide');
		});
	})
</script>
</html>