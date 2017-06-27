<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Compiled and minified JavaScript -->
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=
6ae58faecc0e06a5ecbf63977aa440b0&libraries=clusterer"></script>
<style type="text/css">
	.imge{
		width:100%;
		border-radius:10px;
		padding-top : calc (300 / 1000 * 100 %);
	}
	
	.imge img{
		width: 100%;
		border-radius:10px;
	}
	
	#content.row .col{
		padding:0px;
	}
	.geo_loding{
		display:inline;
	}
	.img_loding{
		display:inline;
	}
</style>
<div class="container" style="width:90%;">
	<!-- <div id="content" class="row">
		<div class="imge col s4 m4" style="background :url('resources/img/1.png') center center / cover no-repeat;">
			<img src="resources/img/1logo.ico">
		</div>
		<div class="imge col s4 m4" style="background: url('resources/img/2.png') center center / cover no-repeat;">
			<img src="resources/img/2logo.png">
		</div>
		<div class="imge col s4 m4" style="background: url('resources/img/3.png') center center / cover no-repeat;">
			<img src="resources/img/3logo.png">
		</div>
	</div> -->
	<c:forEach items="${locationlist}" var="lo">
		${lo.store_name}
	</c:forEach>
</div>
<script type="text/javascript">
	$('img').mouseover(function(){
			var ori = $(this).attr('src');
			$(this).css('opacity','0.1');
			/* $(this).attr('src','resources/img/'+$(this).attr('name')+'logo.png').css({'opacity':'0.5'}); */
			$(this).mouseout(function(){
				$(this).css({'opacity':'1'});
				/* $(this).attr('src',ori); */
			});
	});

	$(document).ready(function(){
		<c:forEach items="${locationlist}" var="lo">
			alert('${lo.store_name}');
		</c:forEach>
			$('.geo_loding').css('display','inline');
		})
</script>

