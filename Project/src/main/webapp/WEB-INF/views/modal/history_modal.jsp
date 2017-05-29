<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" import="spring.mvc.whame.history.*,spring.mvc.whame.store.*,spring.mvc.whame.region.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Modal Structure -->
<%
   if(request.getAttribute("storelist") != null){
   HashMap<Integer, LocationVO> lvo = (HashMap<Integer, LocationVO>) request.getAttribute("locationlist");
   List<StoreVO> svo = (List<StoreVO>) request.getAttribute("storelist");
   HashMap<Integer, List<MenuVO>> menulist = (HashMap<Integer, List<MenuVO>>) request.getAttribute("menulist");

%>

<%
   for (int i = 0; i < svo.size(); i++) {
      int store_code = svo.get(i).getStore_code();
      List<MenuVO> menu = menulist.get(store_code);
      LocationVO location = lvo.get(store_code);
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
         <h4>가게정보</h4>
         <table>
            <tr><th>가게이름</th><td><%=svo.get(i).getStore_name() %></td></tr>
            <tr><th>사업자등록번호</th><td><%=svo.get(i).getStore_name() %></td></tr>
            <tr><th>점주아이디</th><td><%=svo.get(i).getUserid() %></td></tr>
            <tr><th>영업시간</th><td><%=svo.get(i).getOperating_time() %></td></tr>
            <tr><th>조회수</th><td><%=svo.get(i).getView_count() %></td></tr>
            <tr><th>주소</th><td><%=location.getAddress() %></td></tr>
         </table>
      </div>
      <div id="<%=store_code%>,<%=location.getLat() %>,<%=location.getLon() %>">
         <input type="button" value="지도보기" >
         <div id="<%=store_code%>map_modal" class="mapP">
         </div>
      </div>
      <div class="modal-footer">
         <a href="#!" class="modal-action modal-close btn" id="his_su">확인</a>
      </div>
   </div>
</div>
<%
   }}
%>

<script type="text/javascript">
   $(document).ready( function() {
      $('input[value=지도보기]').on('click',function(){
         var store_code = $(this).parent().attr('id');
         var linfo = store_code.split(",");
         console.log("map부분 store_code " + linfo[2]);
         $('#'+linfo[0]+'map_modal').css({'width':'100%','height':'350px',
            'visibility':'visible'});
         var container = document.getElementById(linfo[0]+'map_modal');
         var options = {
            center: new daum.maps.LatLng(linfo[1],linfo[2]),
            level: 4
         };
         var map = new daum.maps.Map(container, options);
         var marker = new daum.maps.Marker({
                map: map,
                position: options.center
            });
      });
      
      $('#his_su').on('click',function(){
         $('div[class=mapP]').css({'width':'0px','height':'0px',
            'visibility':'hidden'});
      })
   })
</script>