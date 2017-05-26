<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="spring.mvc.whame.store.*,java.util.*"%>
<%
	if (request.getAttribute("storelist") != null) {
		List<StoreVO> svo = (List<StoreVO>) request.getAttribute("storelist");
		HashMap<Integer, List<MenuVO>> menulist = (HashMap<Integer, List<MenuVO>>) request.getAttribute("menulist");
		List<TypeVO> tvo = (List<TypeVO>) request.getAttribute("typelist");
%>

<%
	for (int i = 0; i < svo.size(); i++) {
			int store_code = svo.get(i).getStore_code();
%>
 <div class="container center-align">
 	<div id="<%=store_code%>modal_store" class="modal">
		<div class="modal-content" id='<%=store_code %>'>
			<h4><%=svo.get(i).getStore_name()%></h4>
			<input type="button" value="상가삭제" class="btn">
		</div>
		<div class="modal-footer">
			<a href="#!" class="modal-action modal-close btn green floting" style="float:none;">확인</a>
			<a href="#<%=store_code%>modal_store_re" class="modal-action modal-close btn red floting" style="float:none;">변경</a>
		</div>
	</div>
 </div>
 <%}}%>
 
 <script type="text/javascript">
 	$(document).ready(function(){
		$('input[value=상가삭제]').on('click',function(){
			var is = confirm('상가를 정말 삭제하시겠습니까? \n ** 주의 ** \n 한번 삭제시 돌릴 수 없음');
			var store_code = $(this).parent().attr('id');

			if(is == true)
				{			
					$.ajax({
						url : 'deleteStore.whame',
						type : 'post',
						data : {
							'store_code' : store_code
						},
						success : function(result){
							if(result == 1)
								{
									$(location).attr('href','store.whame');
								}
						}
					});
				}
		});
 	 });
 </script>