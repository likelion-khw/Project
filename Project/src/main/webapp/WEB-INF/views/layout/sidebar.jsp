<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="spring.mvc.whame.login.*"%>
	<%@include file="../modal/search_cg_modal.jsp" %>
	<%@include file="../modal/fileupload_modal.jsp" %>
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
#mobile-demo li.topli{
	height: 240px;
}
<% if(membervo != null){%>
@media only screen and (min-width : 200px) and (max-width:991px) {
	.side-nav .userView{
		margin-top: -45px;
	}
	.white-text.name.top{
		margin-top: -20px;
	}
	#mobile-demo li.topli{
		height: 280px;
	}
}
<%}%>
</style>
<ul id="mobile-demo" class="side-nav fixed" style="width:240px">
    <li style="background-color:#673ab7;" class="topli">
    <div class="userView">
			<div class="center-align">
				<c:choose>
					<c:when test="${memberVO.userid != null }">
						<%if(membervo.getUserimage() == null){ %>
						<a href="javascript:re_member();">
						<img class="circle" src="resources/img/user.png"></a> 
						<%}else{ %>
						<a href="javascript:re_member();">
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
    		<!-- <li class="center-align"><a href="javascript:main();">Home</a></li>
		  	<li><div class="divider"></div></li> -->
		  	<li class="no-padding">
		        <ul class="collapsible collapsible-accordion">
		          <li class="">
		            <a class="collapsible-header">Service<i class="material-icons">arrow_drop_down</i></a>
		            <div class="collapsible-body">
		              <ul>
		                <li class="center-align"><a href="javascript:t();" name="msearch"><i class="material-icons" style="margin-right:0px;">camera_enhance</i>메뉴찾기</a></li>
					  	 <li class="center-align"><a href="javascript:t();" name="menroll"><i class="material-icons" style="margin-right:0px;">mode_edit</i>간판등록</a></li>
					  	 <li class="center-align"><a href="javascript:t();" name="rsearch"><i class="material-icons" style="margin-right:0px;">search</i>주변검색</a></li>
		              </ul>
		            </div>
		          </li>
		        </ul>
		      </li>
		  	<!-- <li><div class="divider"></div></li>
		    <li class="center-align">사 용 자 메 뉴</li> -->
		    <li><div class="divider"></div></li>
		    <li class="no-padding">
		        <ul class="collapsible collapsible-accordion">
		          <li class="active">
		            <a class="collapsible-header active">My<i class="material-icons">arrow_drop_down</i></a>
		            <div class="collapsible-body">
		              <ul>
		                <li class="center-align"><a href="javascript:re_member();"><i class="material-icons" style="margin-right:0px;">account_box</i>개인정보</a></li>
		                <li class="center-align"><a href="javascript:logout();"><i class="material-icons" style="margin-right:0px;">power_settings_new</i>로그아웃</a></li>
		              </ul>
		            </div>
		          </li>
		        </ul>
		      </li>
		      
		      <li class="no-padding">
		        <ul class="collapsible collapsible-accordion">
		          <li class="active">
		            <a class="collapsible-header active">History<i class="material-icons">arrow_drop_down</i></a>
		            <div class="collapsible-body">
		              <ul>
		                <li class="center-align"><a href="javascript:history();"><i class="material-icons" style="margin-right:0px;">bookmark</i>나의 히스토리</a></li>
		              </ul>
		            </div>
		          </li>
		        </ul>
		      </li>
		      
		      <li class="no-padding">
		        <ul class="collapsible collapsible-accordion">
		          <li class="active">
		            <a class="collapsible-header active">Shop<i class="material-icons">arrow_drop_down</i></a>
		            <div class="collapsible-body">
		              <ul>
		                <li class="center-align"><a href="javascript:storeform();"><i class="material-icons" style="margin-right:0px;">store</i>음식점 정보</a></li>
		              </ul>
		            </div>
		          </li>
		        </ul>
		      </li>
    	</c:when>
    	<c:when test="${memberVO.userid == null}">
    		 <!-- <li class="center-align"><a href="javascript:main();">Home</a></li>
		  	 <li><div class="divider"></div></li> -->
		  	 <li class="no-padding">
		        <ul class="collapsible collapsible-accordion">
		          <li class="active">
		            <a class="collapsible-header active">Service<i class="material-icons">arrow_drop_down</i></a>
		            <div class="collapsible-body">
		              <ul>
		                <li class="center-align"><a href="javascript:t();" name="msearch"><i class="material-icons" style="margin-right:0px;">camera_enhance</i>메뉴찾기</a></li>
					  	 <li class="center-align"><a href="javascript:t();" name="menroll"><i class="material-icons" style="margin-right:0px;">mode_edit</i>간판등록</a></li>
					  	 <li class="center-align"><a href="javascript:t();" name="rsearch"><i class="material-icons" style="margin-right:0px;">search</i>주변검색</a></li>
		              </ul>
		            </div>
		          </li>
		        </ul>
		      </li>
    	</c:when>
    </c:choose>
 </ul>
 
<button  data-activates="search_cg" class="btn button-collapse search_cg1" style="display:none;">g</button>
 

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

	$("a[name=msearch]").on('click',function(){
		$('#modal1').modal('open');
	});

	$("a[name=menroll]").on('click',function(event){
		var member = '${memberVO.userid}';
		if(member == "")
			{
				$('#sign_login').modal('open');
			}
		else{
			$(location).attr('href','enroll.whame');
		}
	});
	

	$("a[name=rsearch]").on('click',function(){
		$('#mobile-demo').sideNav('hide');
		$('.search_cg1').sideNav('show');
	});

	 $('.button-collapse.search_cg1').sideNav({
	      menuWidth: 330, // Default is 300
	      edge: 'bottom', // Choose the horizontal origin
	      closeOnClick: true, // Closes side-nav on <a> clicks, useful for Angular/Meteor
	      draggable: true // Choose whether you can drag to open on touch screens
	    }
	  );
</script>