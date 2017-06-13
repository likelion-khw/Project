<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../modal/fileupload_modal.jsp" %>
<!-- Compiled and minified JavaScript -->
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=
03947296fa39c02cca384bf32800c263&libraries=clusterer"></script>
<style type="text/css">
.mainform{
	margin-top: 20px;
	padding-top: 20px;
	padding-bottom: 20px;
	width: 90%;
	}
	
.mainimg{
	width:50%;
}
.main_text{
	padding:20px; width:80%; margin-top:20px;
	background-color: #f5f5f5;
}
.main_mapform{
	margin-bottom:10px;
	width:50%;
	padding:10px;
}
#main_map{
	margin-bottom: 20px;
	height: 300px;
}
.mainrun{
		width:100%;
		height: 270px;
}

@media only screen and (min-width : 321px) and (max-width : 600px) {
	.mainimg{
	width:100%;
	}
	.main_text p{
		font-size:13px;
	}
	.main_text h3{
		font-size:15px;
		font-weight: bolder;
	}
	.mainform input{
		margin-bottom:10px;
	}
	.main_text{
		width:90%;
	}
	
	.main_mapform{
	width:90%;
	}
}
</style>

<div class="container mainform z-depth-3">
	<div class="row">
	<ul class="col s8">
		<c:forEach items="${crawl}" var="craw">
			${craw}
		</c:forEach>
	</ul>
	</div>
</div>

