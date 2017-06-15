<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.carousel .carousel-item{
	opacity:1 !important;
}

.carousel .carousel-item div.row{
	border-radius:20px;
}

div#onetop{
	background-image: url('resources/img/t3.gif');
	background-size: cover;
	width: 100%;
	padding-bottom: 25%;
}

</style>
<div class="container" style="width:100%">
<div id="onetop" class="center-align">
	<a href="#downf" id="down" class="btn" style="margin-top:25%; border-radius:20px;">START</a>
</div>
<div style="height: 1000px;">
<div class="carousel center-align" id="downf">
	<h3>상점</h3>
		<span style="background-color:blue;">
	    <a class="carousel-item" href="#1">
	    	<div class="row" style="border:1px gray solid; height: 300px; padding:10px;">
	    		<div class="col s12" style="height:40%; background-color: gray">
	    			<h5>이미지</h5>
	    		</div>
	    		<div class="col s6">
	    			<h5>설명</h5>
	    		</div>
	    		<div class="col s6">
	    			<h5>설명2</h5>
	    		</div>
	    		<div class="col s12">
	    			<h5>하단</h5>
	    		</div>
	    	</div>
	    </a>
	    <a class="carousel-item" href="#2">
	    	<div class="row" style="border:1px gray solid; height: 300px; padding:10px;">
	    		<div class="col s12" style="height:40%; background-color: gray">
	    			<h5>이미지</h5>
	    		</div>
	    		<div class="col s6">
	    			<h5>설명</h5>
	    		</div>
	    		<div class="col s6">
	    			<h5>설명2</h5>
	    		</div>
	    		<div class="col s12">
	    			<h5>하단</h5>
	    		</div>
	    	</div>
	    </a>
	    <a class="carousel-item" href="#3">
	    	<div class="row" style="border:1px gray solid; height: 300px; padding:10px;">
	    		<div class="col s12" style="height:40%; background-color: gray">
	    			<h5>이미지</h5>
	    		</div>
	    		<div class="col s6">
	    			<h5>설명</h5>
	    		</div>
	    		<div class="col s6">
	    			<h5>설명2</h5>
	    		</div>
	    		<div class="col s12">
	    			<h5>하단</h5>
	    		</div>
	    	</div>
	    </a>
	    <a class="carousel-item" href="#4">
	    	<div class="row" style="border:1px gray solid; height: 300px; padding:10px;">
	    		<div class="col s12" style="height:40%; background-color: gray">
	    			<h5>이미지</h5>
	    		</div>
	    		<div class="col s6">
	    			<h5>설명</h5>
	    		</div>
	    		<div class="col s6">
	    			<h5>설명2</h5>
	    		</div>
	    		<div class="col s12">
	    			<h5>하단</h5>
	    		</div>
	    	</div>
	    </a>
	    <a class="carousel-item" href="#5">
	    	<div class="row" style="border:1px gray solid; height: 300px; padding:10px;">
	    		<div class="col s12" style="height:40%; background-color: gray">
	    			<h5>이미지</h5>
	    		</div>
	    		<div class="col s6">
	    			<h5>설명</h5>
	    		</div>
	    		<div class="col s6">
	    			<h5>설명2</h5>
	    		</div>
	    		<div class="col s12">
	    			<h5>하단</h5>
	    		</div>
	    	</div>
	    </a>
	  </div>
  </div>
</div>
<script type="text/javascript">
$(document).ready(function(){
    $('.carousel').carousel({
          dist:0,
          shift:0,
          padding:60,
    });

    $("#down").click(function(event){            
        event.preventDefault();
        $('html,body').animate({scrollTop:$(this.hash).offset().top}, 1000);
	});

  });
</script>
