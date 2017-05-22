<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, height=device-height">
<script type="text/javascript" src="resources/js/jquery-3.1.1.min.js"></script>
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
		$('.modal').modal();
	})
</script>
</html>