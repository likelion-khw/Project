<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="spring.mvc.whame.login.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	MemberVO membervo = (MemberVO) session.getAttribute("memberVO");
%>
<style>
.side-nav .userView .circle{
	width: 80px; 
	height: 80px;
	margin-left: auto;
	margin-right: auto;
}
@media only screen and (min-width : 200px) and (max-width:991px) {
	.side-nav .userView{
		margin-top: -45px;
	}
	.white-text.name.top{
		margin-top: -20px;
	} 
}
</style>
<ul id="mobile-demo" class="side-nav fixed" style="width:240px">
    <li style="background-color:#673ab7; height:240px;">
    <div class="userView">
			<div class="center-align">
				<c:choose>
					<c:when test="${memberVO.userid != null }">
						<%if(membervo.getUserimage() == null){ %>
						<a href="#!user">
						<img class="circle" src="resources/img/user.png"></a> 
						<%}else{ %>
						<a href="#!user">
						<img class="circle" src="<%=membervo.getUserimage()%>"></a> 
						<%} %>
						<span class="white-text name top"> ${memberVO.nickname} 회원님
						</span>
						<span class="white-text name"> ${memberVO.userid}
						</span>
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
		    <li class="center-align"><a href="javascript:qna();">도 움 말</a></li>
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
		                <li><a href="javascript:storeform();">음식점 정보</a></li>
		              </ul>
		            </div>
		          </li>
		        </ul>
		      </li>
    	</c:when>
    	<c:when test="${memberVO.userid == null}">
    		 <li class="center-align"><a href="javascript:main();">Home</a></li>
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

		FB.logout();
	}

	function login(){
		$('#sign_login').modal('open');
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
	function qna(){
		$(location).attr('href', 'qna.whame');
	}
</script>