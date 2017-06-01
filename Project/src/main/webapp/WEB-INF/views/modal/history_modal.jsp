<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" import="spring.mvc.whame.history.*,spring.mvc.whame.store.*,spring.mvc.whame.region.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Modal Structure -->
<%
   if(request.getAttribute("storelist") != null){
   HashMap<Integer, LocationVO> lvo = (HashMap<Integer, LocationVO>) request.getAttribute("locationlist");
   List<StoreVO> svo = (List<StoreVO>) request.getAttribute("storelist");
   HashMap<Integer, List<MenuVO>> menulist = (HashMap<Integer, List<MenuVO>>) request.getAttribute("menulist");
   HashMap<Integer, List<String>> menutype = (HashMap<Integer, List<String>>) request.getAttribute("menutype");

%>

<%
   for (int i = 0; i < svo.size(); i++) {
      int store_code = svo.get(i).getStore_code();
      List<MenuVO> menu = menulist.get(store_code);
      LocationVO location = lvo.get(store_code);
      List<String> menutypel = menutype.get(store_code);
%>

<style>
	.modal.modal-fixed-footer{
		max-height: 200%;
		height: 90%;
	}
	.h_m_storeinfo{
		width:70%;
		float:left;
	}
	.tog{
		display: none;
	}
	.h_m_map{
		width:20%;
		float:right;
		margin-top:20%;
		margin-right:60px;
		margin-bottom:30px;
	}
	.h_m_m{
		margin-bottom:30px;
		padding:20px;
	}
	.hidemenu{
		display: none;
	}
	@media only screen and (min-width : 321px) and (max-width : 600px) {
			.history_modal_form{
			width:90%;
		}
		.h_m_storeinfo{
		width:100%;
		float:none;
		}
		.h_m_map{
			width:100%;
			float:none;
			margin-bottom:30px;
			margin-top:0px;
			margin-right:0px;
	}
		}
		.h_m_m{
			margin-bottom:30px;
		}
	}

</style>
<div class="container center-align">
   <div id="<%=store_code%>modal" class="modal modal-fixed-footer history_modal_form">
      <div class="modal-content">
      <div class="h_m_m z-depth-2">
         <h4><%=svo.get(i).getStore_name()%><br>메뉴</h4>
         <label>메뉴종류</label>
		 	<center>
				<select class="browser-default" id="menu_type" style="width:40%" name="<%=store_code%>">
						<%for(int m=0; m<menutypel.size(); m++){ %>
	   						<option value="<%=store_code%><%=menutypel.get(m)%>"><%=menutypel.get(m)%></option>
	   					<%} %>
	 			</select>
			</center>
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
            <tr class="<%=store_code%>menu_list hidemenu" name="<%=store_code%><%=menu.get(j).getMenu_type()%>">
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
	         <h4>가게정보</h4>
         <div class="h_m_storeinfo">
	         <table>
	            <tr><th>가게이름</th><td><%=svo.get(i).getStore_name() %></td></tr>
	            <tr><th>사업자등록번호</th><td><%=svo.get(i).getStore_name() %></td></tr>
	            <tr><th>점주아이디</th><td><%=svo.get(i).getUserid() %></td></tr>
	            <tr><th>영업시간</th><td><%=svo.get(i).getOperating_time() %></td></tr>
	            <tr><th>조회수</th><td><%=svo.get(i).getView_count() %></td></tr>
	            <tr><th>주소</th><td><%=location.getAddress() %></td></tr>
	         </table>
         </div>
	      <div id="<%=store_code%>,<%=location.getLat() %>,<%=location.getLon() %>" class="h_m_map">
	         <input type="button" value="지도보기" class="btn green">
	         <input type="button" value="감추기" class="btn tog red">
	      </div>
        <div id="<%=store_code%>map_modal" class="mapP">
        </div>
      </div>
      <div class="modal-footer">
         <a href="#!" class="modal-action modal-close btn blue" id="his_su">확인</a>
      </div>
   </div>
</div>
<%
   }}
%>

<script type="text/javascript">
   $(document).ready( function() {
      $('input[value=지도보기]').on('click',function(){
          
         $(this).addClass('tog');
         $(this).next().removeClass('tog');
         var store_code = $(this).parent().attr('id');
         var linfo = store_code.split(",");
         console.log("map부분 store_code " + linfo[2]);
         $('#'+linfo[0]+'map_modal').css({'width':'100%','height':'300px',
            'visibility':'visible'});
         var container = document.getElementById(linfo[0]+'map_modal');
         var options = {
            center: new daum.maps.LatLng(linfo[1],linfo[2]),
            draggable:false,
            level: 4
         };
         var map = new daum.maps.Map(container, options);
         var marker = new daum.maps.Marker({
                map: map,
                position: options.center
            });
      });

      $('input[value=감추기]').on('click',function(){
    	  $(this).addClass('tog');
          $(this).prev().removeClass('tog');
          var store_code = $(this).parent().attr('id');
          var linfo = store_code.split(",");

          $('#'+linfo[0]+'map_modal').css({'width':'0px','height':'0px',
              'visibility':'hidden'});
      });
      
      $('#his_su').on('click',function(){
         $('div[class=mapP]').css({'width':'0px','height':'0px',
            'visibility':'hidden'});
         $('input[value=감추기]').addClass('tog');
         $('input[value=지도보기]').removeClass('tog');
      });

      var selecttype;

      $('select#menu_type').each(function(){
  		var store_code = $(this).attr('name');
  		selecttype = $(this).val();
  		$('tr[class='+store_code+'menu_list]').addClass('hidemenu');
  		var check = /[&]/gi;
  		if(check.test(selecttype) == true){
  			$('tr[name='+store_code+'커피\\&라떼]').removeClass('hidemenu');
  		}else{
  			$('tr[name='+selecttype+']').removeClass('hidemenu');
  		}
  	});
  	
  	$('select#menu_type').on('change',function(){
  		var store_code = $(this).attr('name');
  		selecttype = $(this).val();
  		$('tr[class='+store_code+'menu_list]').addClass('hidemenu');
  		var check = /[&]/gi;
  		if(check.test(selecttype) == true){
  			$('tr[name='+store_code+'커피\\&라떼]').removeClass('hidemenu');
  		}else{
  			$('tr[name='+selecttype+']').removeClass('hidemenu');
  		}
  	});

      
   })
</script>