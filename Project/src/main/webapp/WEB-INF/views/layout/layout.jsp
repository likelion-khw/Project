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
<link rel="stylesheet" href="resources/css/countstyle.css" type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.5/css/materialize.min.css">
<!-- Compiled and minified JavaScript -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.5/js/materialize.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">


<style type="text/css">
header, main, footer {
	padding-left: 240px;
}

@media only screen and (max-width : 992px) {
	header, main, footer {
		padding-left: 0;
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
	<div class="row">
		<tiles:insertAttribute name="sidebar" />
		<main> <tiles:insertAttribute name="body" /> </main>
	</div>
</body>

<script type="text/javascript">
	$(document).ready(function() {
		 $('.modal').modal({
		      dismissible: true, // Modal can be dismissed by clicking outside of the modal
		      opacity: .10, // Opacity of modal background
		      inDuration: 320, // Transition in duration
		      outDuration: 220, // Transition out duration
		      startingTop: '4%', // Starting top style attribute
		      endingTop: '20%' // Ending top style attribute
		    }
		  );
	})
</script>
</html>