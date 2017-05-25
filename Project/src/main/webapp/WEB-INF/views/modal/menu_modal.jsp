<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="spring.mvc.whame.store.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Modal Structure -->
<%
	if(request.getAttribute("storelist") != null){
	List<StoreVO> svo = (List<StoreVO>) request.getAttribute("storelist");
	HashMap<Integer, List<MenuVO>> menulist = (HashMap<Integer, List<MenuVO>>) request.getAttribute("menulist");

%>

<%
	for (int i = 0; i < svo.size(); i++) {
		int store_code = svo.get(i).getStore_code();
		List<MenuVO> menu = menulist.get(store_code);
%>

<div class="container center-align">
	<div id="<%=store_code%>modal" class="modal">
		<div class="modal-content">
			<h4><%=svo.get(i).getStore_name()%></h4>
			<table class="centered highlight">
				<thead>
					<tr>
						<th>메뉴타입</th>
						<th>메뉴이름</th>
						<th>가격</th>
					</tr>
				</thead>
				<tbody>
				<%
					for (int j = 0; j < menu.size(); j++) {
				%>
				<tr>
					<td><%=menu.get(j).getMenu_type()%></td>
					<td><%=menu.get(j).getMenu_name()%></td>
					<td><%=menu.get(j).getMenu_price()%></td>
				</tr>
				<%
					}
				%>
				</tbody>
			</table>
		</div>
		<div class="modal-footer">
			<a href="#!" class="modal-action modal-close btn">확인</a>
		</div>
	</div>
</div>
<%
	}}
%>