<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="spring.mvc.whame.login.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	MemberVO membervo = (MemberVO) session.getAttribute("memberVO");
%>

<ul id="mobile-demo" class="side-nav fixed">
    <li style="background-color:#8e24aa; height:200px;">
    <div class="userView">
			<div class="center-align" style="padding-top:10px;">
				<c:choose>
					<c:when test="${memberVO.userid != null }">
						<%if(membervo.getUserimage() == null){ %>
						<a href="#!user">
						<img class="circle" src="resources/img/user.png" style="width: 80px; height: 80px;"></a> 
						<%}else{ %>
						<a href="#!user">
						<img class="circle" src="<%=membervo.getUserimage()%>" style="width: 80px; height: 80px;"></a> 
						<%} %>
						<a href="#!name"> <span class="white-text name"> ${memberVO.nickname} 회원님
						</span></a>
						<a href="#!name"> <span class="white-text name"> ${memberVO.userid}
						</span></a>
					</c:when>
					<c:when test="${memberVO.userid == null }">
					<span class="white-text name"> 로그인이 필요합니다.</span><br>
					<a href="javascript:login();"><i class="material-icons" style="color:white">input</i></a>
					</c:when>
				</c:choose>
			</div>
		</div>
    </li>
    <c:choose>
    	<c:when test="${memberVO.userid != null}">
    		<li class="center-align"><a href="javascript:main();">Home</a></li>
		  	<li><div class="divider"></div></li>
		    <li class="center-align">사 용 자 메 뉴</li>
		    <li><div class="divider"></div></li>
		    <li class="no-padding">
		        <ul class="collapsible collapsible-accordion">
		          <li>
		            <a class="collapsible-header">My<i class="material-icons">arrow_drop_down</i></a>
		            <div class="collapsible-body">
		              <ul>
		                <li><a href="javascript:re_member();">개인정보</a></li>
		                <li><a href="javascript:logout();">로그아웃</a></li>
		              </ul>
		            </div>
		          </li>
		        </ul>
		      </li>
		      
		      <li class="no-padding">
		        <ul class="collapsible collapsible-accordion">
		          <li>
		            <a class="collapsible-header">History<i class="material-icons">arrow_drop_down</i></a>
		            <div class="collapsible-body">
		              <ul>
		                <li><a href="javascript:history();">나의 히스토리</a></li>
		              </ul>
		            </div>
		          </li>
		        </ul>
		      </li>
		      
		      <li class="no-padding">
		        <ul class="collapsible collapsible-accordion">
		          <li>
		            <a class="collapsible-header">Shop<i class="material-icons">arrow_drop_down</i></a>
		            <div class="collapsible-body">
		              <ul>
		                <li><a href="javascript:storeform();">상가정보</a></li>
		              </ul>
		            </div>
		          </li>
		        </ul>
		      </li>
    	</c:when>
    	<c:when test="${memberVO.userid == null}">
    		 <li class="center-align"><a href="javascript:home();">Home</a></li>
		  	 <li><div class="divider"></div></li>
    	</c:when>
    </c:choose>
 </ul>
 

<script type="text/javascript">
Kakao.init('f83177e46350e0d7ba18232a50b978ed');

	$('.button-collapse').sideNav();
	
	function logout(){
		Kakao.Auth.logout(function(){
			setTimeout(function(){
					$(location).attr('href', 'logout.whame');
				},1000);
		});
	}

	function login(){
		$(location).attr('href', 'login.whame');
	}
	function sign(){
		$(location).attr('href', 'sign.whame');
	}
	function main(){
		$(location).attr('href', '/whame');
	}
	function re_member(){
		$(location).attr('href', 'remember.whame');
	}
	function history(){
		$(location).attr('href', 'history.whame');
	}
	function storeform(){
		$(location).attr('href', 'store.whame');
	}
</script>