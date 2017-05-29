<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="spring.mvc.whame.login.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../modal/signin_modal.jsp" %>
<style>
@import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css);
 .mfont{
	font-family:  'Nanum Pen Script';
 }
</style>
<script type="text/javascript">
		function logout(){
			$(location).attr('href', 'logout.whame');
		}
	
		function login(){
			$(location).attr('href', 'login.whame');
		}
	
		function main(){
			$(location).attr('href', '/whame');
		}

</script>
	<nav class="navbar-fixed">
	    <div class="nav-wrapper purple darken-2">
	      <a href="javascript:main();" class="brand-logo center mfont">Whame</a>
	      <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
	      <ul class="right hide-on-med-and-down">
	      <c:choose>
		      <c:when test="${memberVO.userid == null }">
		        <li class="mfont"><a href="javascript:login();">LogIn</a></li>
		        <li class="mfont"><a href="#signin">Join</a></li>
		      </c:when>
		      <c:when test="${memberVO.userid != null }">
		      	<li class="mfont"><a href="javascript:logout();">LogOut</a></li>
		      </c:when>
	      </c:choose>
	      </ul>
	    </div>
	</nav>
