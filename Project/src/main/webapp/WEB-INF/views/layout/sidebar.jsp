<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="spring.mvc.whame.login.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	MemberVO membervo = null;
	if ((MemberVO) session.getAttribute("memberVO") != null) {
		membervo = (MemberVO) session.getAttribute("memberVO");
	}
%>

<ul id="mobile-demo" class="side-nav fixed">
    <li style="background-color:#8e24aa; height:200px;">
    <div class="userView">
	      <div class="background">
	      </div>
				<div class="center-align" style="padding-top:10px;">
					<%if (membervo.getUserid() != null) {%>
					<a href="#!user"><img class="circle"
						src="resources/img/scon.jpg" style="width: 80px"></a> <a
						href="#!name"> <span class="white-text name"> <%= membervo.getUserid() %>
							회원님
					</span>
					</a> <a href="#!email"><span class="white-text email"><%= membervo.getUserid() %>
							@asdfsadf.saf</span></a>
					<%}else{%>
					<span class="white-text name"> 로그인이 필요합니다.</span><br>
					<a href="javascript:login();"><i class="material-icons" style="color:white">input</i></a>
					<%} %>
				</div>
		</div>
    </li>
    <li class="center-align">사 용 자 메 뉴</li>
    <li><div class="divider"></div></li>
    <li class="no-padding">
        <ul class="collapsible collapsible-accordion">
          <li>
            <a class="collapsible-header">나의 정보<i class="material-icons">arrow_drop_down</i></a>
            <div class="collapsible-body">
              <ul>
                <li><a href="#!">개인정보</a></li>
                <li><a href="javascript:logout();">로그아웃</a></li>
              </ul>
            </div>
          </li>
        </ul>
      </li>
      
      <li class="no-padding">
        <ul class="collapsible collapsible-accordion">
          <li>
            <a class="collapsible-header">히스토리<i class="material-icons">arrow_drop_down</i></a>
            <div class="collapsible-body">
              <ul>
                <li><a href="#!">뭘 넣지</a></li>
              </ul>
            </div>
          </li>
        </ul>
      </li>
 </ul>
 

<script type="text/javascript">
	$('.button-collapse').sideNav();
	function logout(){
		$(location).attr('href', 'logout.whame');
	}
	function login(){
		$(location).attr('href', 'login.whame');
	}
	function sign(){
		$(location).attr('href', 'sign.whame');
	}
</script>