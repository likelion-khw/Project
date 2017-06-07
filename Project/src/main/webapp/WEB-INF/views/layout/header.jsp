<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="spring.mvc.whame.login.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../modal/signin_modal.jsp" %>
<style>
@import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css);
 .mfont{
	font-family:  'Nanum Pen Script';
	font-weight: bolder;
 }
 
.navbar-fixed{
}

@media only screen and (min-width : 1300px) and (max-width:1920px) {
	.navbar-fixed{
		height: 80px;
	}
	.nav-wrapper{
		padding-top:10px;
	}
	
}
</style>

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">
</script>
	<nav class="navbar-fixed">
	    <div class="nav-wrapper deep-purple darken-1">
	      <a href="javascript:main();" class="brand-logo center mfont"><span style="font-size:50px">Whame</span></a>
	      <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
	      <ul class="right hide-on-med-and-down">
	      <c:choose>
		      <c:when test="${memberVO.userid == null }">
		        <li class="mfont"><a href="javascript:login();"><span style="font-size:20px;">LogIn</span></a></li>
		        <li class="mfont"><a href="#signin"><span style="font-size:20px;">Join</span></a></li>
		      </c:when>
		      <c:when test="${memberVO.userid != null }">
		      	<li class="mfont"><a href="javascript:logout();"><span style="font-size:20px;">LogOut</span></a></li>
		      </c:when>
	      </c:choose>
	      </ul>
	    </div>
	</nav>
