<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="spring.mvc.whame.login.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../modal/signin_modal.jsp" %>
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
	      <a href="javascript:main();" class="brand-logo center">Whame</a>
	      <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
	      <ul class="right hide-on-med-and-down">
	      <c:choose>
		      <c:when test="${memberVO.userid == null }">
		        <li><a href="javascript:login();">로그인</a></li>
		        <li><a href="#signin">회원가입</a></li>
		      </c:when>
		      <c:when test="${memberVO.userid != null }">
		      	<li><a href="javascript:logout();">로그아웃</a></li>
		      </c:when>
	      </c:choose>
	      </ul>
	    </div>
	</nav>
